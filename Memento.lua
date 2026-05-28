local addonName, MEM = ...

local Capture = MEM.modules.Capture
local Options = MEM.modules.Options
local Utils = MEM.modules.Utils

local fixDelay = 0.1
local minutesPassed = 0
local sessionStartTime = 0

--------------
--- Frames ---
--------------

local MementoFrame = CreateFrame("Frame", "Memento")

-----------------------
--- Local Functions ---
-----------------------

local function TimePlayed()
	local currentTime = GetTime()
	local timeLastCheck = currentTime - sessionStartTime

	MEM.state.totalTimePlayed = MEM.state.totalTimePlayed + timeLastCheck
	MEM.state.timePlayedThisLevel = MEM.state.timePlayedThisLevel + timeLastCheck

	sessionStartTime = currentTime
end

local function CheckInterval()
	Utils:PrintDebug("Timer triggered.")

	minutesPassed = minutesPassed + 1

	if MEM.settings.event["interval-active"] and minutesPassed >= MEM.settings.event["interval-timer"] then
		TimePlayed()

		Capture:ScheduleTimer("IntervalEventHandler", fixDelay)

		minutesPassed = 0
	end
end

local function IsPlayerWinner(winner)
	local playerFaction = UnitFactionGroup("player")

	return (playerFaction == "Alliance" and winner == 1) or (playerFaction == "Horde" and winner == 0)
end

local function SlashCommand(msg, editbox)
	if not msg or strtrim(msg) == "" then
		if not InCombatLockdown() then
			Settings.OpenToCategory(MEM.MAIN_CATEGORY_ID)
		else
			Utils:PrintDebug("In combat. The options menu cannot be opened.")
		end
	else
		Utils:PrintDebug("These arguments are not accepted.")
	end
end

------------------------
--- Public Functions ---
------------------------

function MementoFrame:OnEvent(event, ...)
	self[event](self, event, ...)
end

function MementoFrame:ADDON_LOADED(_, addOnName)
	if addOnName == addonName then
		sessionStartTime = GetTime()

		Utils:InitializeDatabase()
		Utils:InitializeMinimapButton()
		Options:Initialize()

		RequestTimePlayed()
		Utils:OpenSettingsOnLoading()

		C_Timer.NewTicker(60, CheckInterval)

		Utils:PrintDebug("Addon fully loaded.")
	end
end

function MementoFrame:TIME_PLAYED_MSG(_, totalTimePlayed, timePlayedThisLevel)
	Utils:PrintDebug(string.format(
		"Event 'TIME_PLAYED_MSG' fired. Payload: totalTimePlayed=%s, timePlayedThisLevel=%s",
		tostring(totalTimePlayed), tostring(timePlayedThisLevel)
	))

	MEM.state.totalTimePlayed = totalTimePlayed
	MEM.state.timePlayedThisLevel = timePlayedThisLevel

	sessionStartTime = GetTime()

	Utils:PrintDebug("Event 'TIME_PLAYED_MSG' completed.")
end

function MementoFrame:ACHIEVEMENT_EARNED(_, achievementID, alreadyEarned)
	Utils:PrintDebug(string.format(
		"Event 'ACHIEVEMENT_EARNED' fired. Payload: achievementID=%s, alreadyEarned=%s",
		tostring(achievementID), tostring(alreadyEarned)
	))

	local isGuildAchievement = select(12, GetAchievementInfo(achievementID))

	if not isGuildAchievement then
		if MEM.settings.event["achievement-personal-active"] then
			TimePlayed()
			Capture:ScheduleTimer("AchievementPersonalEventHandler", MEM.settings.event["achievement-personal-delay"] + fixDelay, achievementID, alreadyEarned)
		else
			Utils:PrintDebug("Event 'ACHIEVEMENT_EARNED' (Personal) completed. No screenshot requested.")
		end
	else
		if MEM.settings.event["achievement-guild-active"] then
			TimePlayed()
			Capture:ScheduleTimer("AchievementGuildEventHandler", MEM.settings.event["achievement-guild-delay"] + fixDelay, achievementID)
		else
			Utils:PrintDebug("Event 'ACHIEVEMENT_EARNED' (Guild) completed. No screenshot requested.")
		end
	end
end

function MementoFrame:CRITERIA_EARNED(_, achievementID, description)
	Utils:PrintDebug(string.format(
		"Event 'CRITERIA_EARNED' fired. Payload: achievementID=%s, description=%s",
		tostring(achievementID), tostring(description)
	))

	if MEM.settings.event["achievement-criteria-active"] then
		TimePlayed()
		Capture:ScheduleTimer("CriteriaEventHandler", MEM.settings.event["achievement-criteria-delay"] + fixDelay, achievementID, description)
	else
		Utils:PrintDebug("Event 'CRITERIA_EARNED' completed. No screenshot requested.")
	end
end

function MementoFrame:CHALLENGE_MODE_COMPLETED(_)
	Utils:PrintDebug("Event 'CHALLENGE_MODE_COMPLETED' fired. No payload.")

	if MEM.settings.event["mythic-active"] then
		TimePlayed()
		Capture:ScheduleTimer("MythicEventHandler", MEM.settings.event["mythic-delay"] + fixDelay)
	else
		Utils:PrintDebug("Event 'CHALLENGE_MODE_COMPLETED' completed. No screenshot requested.")
	end
end

function MementoFrame:PVP_MATCH_COMPLETE(_, winner, duration)
	Utils:PrintDebug(string.format(
		"Event 'PVP_MATCH_COMPLETE' fired. Payload: winner=%s, duration=%s",
		tostring(winner), tostring(duration)
	))

	local isArena = C_PvP.IsArena()
	local isBattleground = C_PvP.IsBattleground()
	local isSoloRBG = C_PvP.IsSoloRBG()
	local isInBrawl = C_PvP.IsInBrawl()

	if isArena then
		if MEM.settings.event["pvp-arena-active"] then
			TimePlayed()
			Capture:ScheduleTimer("PvPArenaEventHandler", MEM.settings.event["pvp-arena-delay"] + fixDelay)
		else
			Utils:PrintDebug("Event 'PVP_MATCH_COMPLETE' (Arena) completed. No screenshot requested.")
		end
	elseif isInBrawl then
		if MEM.settings.event["pvp-brawl-active"] then
			if MEM.settings.event["pvp-brawl-victory-only"] then
				if IsPlayerWinner(winner) then
					TimePlayed()
					Capture:ScheduleTimer("PvPBrawlEventHandler", MEM.settings.event["pvp-brawl-delay"] + fixDelay)
				else
					Utils:PrintDebug("Player faction has lost the brawl. No screenshot requested.")
				end
			else
				TimePlayed()
				Capture:ScheduleTimer("PvPBrawlEventHandler", MEM.settings.event["pvp-brawl-delay"] + fixDelay)
			end
		else
			Utils:PrintDebug("Event 'PVP_MATCH_COMPLETE' (Brawl) completed. No screenshot requested.")
		end
	elseif isBattleground or isSoloRBG then
		if MEM.settings.event["pvp-battleground-active"] then
			if MEM.settings.event["pvp-battleground-victory-only"] then
				if IsPlayerWinner(winner) then
					TimePlayed()
					Capture:ScheduleTimer("PvPBattlegroundEventHandler", MEM.settings.event["pvp-battleground-delay"] + fixDelay)
				else
					Utils:PrintDebug("Player faction has lost the battleground. No screenshot requested.")
				end
			else
				TimePlayed()
				Capture:ScheduleTimer("PvPBattlegroundEventHandler", MEM.settings.event["pvp-battleground-delay"] + fixDelay)
			end
		else
			Utils:PrintDebug("Event 'PVP_MATCH_COMPLETE' (Battleground) completed. No screenshot requested.")
		end
	else
		Utils:PrintDebug("Unknown PvP Event. No screenshot requested.")
	end
end

function MementoFrame:NEW_PET_ADDED(_, battlePetGUID)
	Utils:PrintDebug(string.format(
		"Event 'NEW_PET_ADDED' fired. Payload: battlePetGUID=%s",
		tostring(battlePetGUID)
	))

	if MEM.settings.event["collection-pet-active"] then
		TimePlayed()
		Capture:ScheduleTimer("NewPetEventHandler", MEM.settings.event["collection-pet-delay"] + fixDelay)
	else
		Utils:PrintDebug("Event 'NEW_PET_ADDED' completed. No screenshot requested.")
	end
end

function MementoFrame:NEW_MOUNT_ADDED(_, mountID)
	Utils:PrintDebug(string.format(
		"Event 'NEW_MOUNT_ADDED' fired. Payload: mountID=%s",
		tostring(mountID)
	))

	if MEM.settings.event["collection-mount-active"] then
		TimePlayed()
		Capture:ScheduleTimer("NewMountEventHandler", MEM.settings.event["collection-mount-delay"] + fixDelay)
	else
		Utils:PrintDebug("Event 'NEW_MOUNT_ADDED' completed. No screenshot requested.")
	end
end

function MementoFrame:NEW_TOY_ADDED(_, itemID)
	Utils:PrintDebug(string.format(
		"Event 'NEW_TOY_ADDED' fired. Payload: itemID=%s",
		tostring(itemID)
	))

	if MEM.settings.event["collection-toy-active"] then
		TimePlayed()
		Capture:ScheduleTimer("NewToyEventHandler", MEM.settings.event["collection-toy-delay"] + fixDelay)
	else
		Utils:PrintDebug("Event 'NEW_TOY_ADDED' completed. No screenshot requested.")
	end
end

function MementoFrame:NEW_HOUSING_ITEM_ACQUIRED(_, itemType, itemName, icon)
	Utils:PrintDebug(string.format(
		"Event 'NEW_HOUSING_ITEM_ACQUIRED' fired. Payload: itemType=%s, itemName=%s, icon=%s",
		tostring(itemType),	tostring(itemName),	tostring(icon)
	))

	if MEM.settings.event["collection-housing-active"] then
		TimePlayed()
		Capture:ScheduleTimer("NewHousingItemEventHandler", MEM.settings.event["collection-housing-delay"] + fixDelay)
	else
		Utils:PrintDebug("Event 'NEW_HOUSING_ITEM_ACQUIRED' completed. No screenshot requested.")
	end
end

function MementoFrame:PLAYER_ENTERING_WORLD(_, isInitialLogin, isReloadingUi)
	Utils:PrintDebug(string.format(
		"Event 'PLAYER_ENTERING_WORLD' fired. Payload: isInitialLogin=%s, isReloadingUi=%s",
		tostring(isInitialLogin), tostring(isReloadingUi)
	))

	if MEM.settings.event["login-active"] and isInitialLogin then
		TimePlayed()
		Capture:ScheduleTimer("LoginEventHandler", MEM.settings.event["login-delay"] + fixDelay)
	else
		Utils:PrintDebug("Event 'PLAYER_ENTERING_WORLD' completed. No screenshot requested.")
	end
end

function MementoFrame:PLAYER_DEAD(_)
	Utils:PrintDebug("Event 'PLAYER_DEAD' fired. No payload.")

	if MEM.settings.event["death-active"] then
		TimePlayed()
		local inInstance = IsInInstance()

		if MEM.settings.event["death-instance"] == 0 then
			Capture:ScheduleTimer("DeathEventHandler", MEM.settings.event["death-delay"] + fixDelay)
		elseif inInstance and MEM.settings.event["death-instance"] == 1 then
			Capture:ScheduleTimer("DeathEventHandler", MEM.settings.event["death-delay"] + fixDelay)
		elseif not inInstance and MEM.settings.event["death-instance"] == 2 then
			Capture:ScheduleTimer("DeathEventHandler", MEM.settings.event["death-delay"] + fixDelay)
		else
			Utils:PrintDebug("Player died in the wrong area. No screenshot requested.")
		end
	else
		Utils:PrintDebug("Event 'PLAYER_DEAD' completed. No screenshot requested.")
	end
end

function MementoFrame:PLAYER_LEVEL_UP(_, level)
	Utils:PrintDebug(string.format(
		"Event 'PLAYER_LEVEL_UP' fired. Payload: level=%s",
		tostring(level)
	))

	if MEM.settings.event["level-up-active"] then
		TimePlayed()
		Capture:ScheduleTimer("LevelUpEventHandler", MEM.settings.event["level-up-delay"] + fixDelay, level)
	else
		Utils:PrintDebug("Event 'PLAYER_LEVEL_UP' completed. No screenshot requested.")
	end
end

function MementoFrame:ENCOUNTER_END(_, encounterID, encounterName, difficultyID, groupSize, success)
	Utils:PrintDebug(string.format(
		"Event 'ENCOUNTER_END' fired. Payload: encounterID=%s, encounterName=%s, difficultyID=%s, groupSize=%s, success=%s",
		tostring(encounterID), tostring(encounterName),	tostring(difficultyID),	tostring(groupSize), tostring(success)
	))

	local difficultyName, groupType = GetDifficultyInfo(difficultyID)
	local difficulty = "D" .. tostring(difficultyID)

	if groupType == "party" or groupType == "raid" or groupType == "scenario" then
		if success == 1 then
			local isActive = (groupType == "party" and MEM.settings.event["encounter-victory-party-active"]) or
								(groupType == "raid" and MEM.settings.event["encounter-victory-raid-active"]) or
								(groupType == "scenario" and MEM.settings.event["encounter-victory-scenario-active"])

			local delay = (groupType == "party" and MEM.settings.event["encounter-victory-party-delay"]) or
							(groupType == "raid" and MEM.settings.event["encounter-victory-raid-delay"]) or
							(groupType == "scenario" and MEM.settings.event["encounter-victory-scenario-delay"])

			local firstOnly = (groupType == "party" and MEM.settings.event["encounter-victory-party-first"]) or
								(groupType == "raid" and MEM.settings.event["encounter-victory-raid-first"]) or
								(groupType == "scenario" and MEM.settings.event["encounter-victory-scenario-first"])

			if isActive then
				if not MEM.data.bossKill[difficulty] then MEM.data.bossKill[difficulty] = {} end

				if MEM.data.bossKill[difficulty][encounterID] and firstOnly then
					Utils:PrintDebug("Encounter already killed. No screenshot requested.")
				else
					TimePlayed()
					Capture:ScheduleTimer("EncounterVictoryEventHandler", delay + fixDelay, encounterName, difficultyName, difficulty, encounterID)
				end
			else
				Utils:PrintDebug("Event 'ENCOUNTER_END' (Victory) completed. No screenshot requested.")
			end
		else
			local isActive = (groupType == "party" and MEM.settings.event["encounter-wipe-party-active"]) or
								(groupType == "raid" and MEM.settings.event["encounter-wipe-raid-active"]) or
								(groupType == "scenario" and MEM.settings.event["encounter-wipe-scenario-active"])

			local delay = (groupType == "party" and MEM.settings.event["encounter-wipe-party-delay"]) or
							(groupType == "raid" and MEM.settings.event["encounter-wipe-raid-delay"]) or
							(groupType == "scenario" and MEM.settings.event["encounter-wipe-scenario-delay"])

			if isActive then
				TimePlayed()
				Capture:ScheduleTimer("EncounterWipeEventHandler", delay + fixDelay, encounterName, difficultyName)
			else
				Utils:PrintDebug("Event 'ENCOUNTER_END' (Wipe) completed. No screenshot requested.")
			end
		end
	else
		Utils:PrintDebug(string.format(
			"Unknown groupType '%s'. No screenshot requested.",
			tostring(groupType)
		))
	end
end

function MementoFrame:DUEL_FINISHED(_)
	Utils:PrintDebug("Event 'DUEL_FINISHED' fired. No payload.")

	if MEM.settings.event["pvp-duel-active"] then
		TimePlayed()
		Capture:ScheduleTimer("PvPDuelEventHandler", MEM.settings.event["pvp-duel-delay"] + fixDelay)
	else
		Utils:PrintDebug("Event 'DUEL_FINISHED' completed. No screenshot requested.")
	end
end

function MementoFrame:NEW_RECIPE_LEARNED(_, recipeID, recipeLevel, baseRecipeID)
	Utils:PrintDebug(string.format(
		"Event 'NEW_RECIPE_LEARNED' fired. Payload: recipeID=%s, recipeLevel=%s, baseRecipeID=%s",
		tostring(recipeID),	tostring(recipeLevel), tostring(baseRecipeID)
	))

	if MEM.settings.event["collection-recipe-active"] then
		TimePlayed()
		Capture:ScheduleTimer("NewRecipeEventHandler", MEM.settings.event["collection-recipe-delay"] + fixDelay)
	else
		Utils:PrintDebug("Event 'NEW_RECIPE_LEARNED' completed. No screenshot requested.")
	end
end

--------------------------
--- Event Registration ---
--------------------------

MementoFrame:RegisterEvent("ADDON_LOADED")
MementoFrame:RegisterEvent("TIME_PLAYED_MSG")

if MEM.GAME_TYPE_VANILLA then
elseif MEM.GAME_TYPE_TBC then
elseif MEM.GAME_TYPE_MISTS then
	MementoFrame:RegisterEvent("ACHIEVEMENT_EARNED")
	MementoFrame:RegisterEvent("NEW_PET_ADDED")
	MementoFrame:RegisterEvent("NEW_MOUNT_ADDED")
	MementoFrame:RegisterEvent("NEW_TOY_ADDED")
elseif MEM.GAME_TYPE_MAINLINE then
	MementoFrame:RegisterEvent("ACHIEVEMENT_EARNED")
	MementoFrame:RegisterEvent("CRITERIA_EARNED")
	MementoFrame:RegisterEvent("CHALLENGE_MODE_COMPLETED")
	MementoFrame:RegisterEvent("PVP_MATCH_COMPLETE")
	MementoFrame:RegisterEvent("ENCOUNTER_END")
	MementoFrame:RegisterEvent("NEW_PET_ADDED")
	MementoFrame:RegisterEvent("NEW_MOUNT_ADDED")
	MementoFrame:RegisterEvent("NEW_TOY_ADDED")
	MementoFrame:RegisterEvent("NEW_HOUSING_ITEM_ACQUIRED")
end

MementoFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
MementoFrame:RegisterEvent("PLAYER_DEAD")
MementoFrame:RegisterEvent("PLAYER_LEVEL_UP")
MementoFrame:RegisterEvent("DUEL_FINISHED")
MementoFrame:RegisterEvent("NEW_RECIPE_LEARNED")

MementoFrame:SetScript("OnEvent", MementoFrame.OnEvent)

SLASH_Memento1, SLASH_Memento2 = '/mem', '/memento'
SlashCmdList["Memento"] = SlashCommand
