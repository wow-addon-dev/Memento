local addonName, MEM = ...

-- Library
local AWL = ArcaneWizardLibrary
local Addon = AWL:GetAddon(addonName)

-- Module imports
local Capture = MEM.Modules.Capture
local Options = MEM.Modules.Options
local Utils = MEM.Modules.Utils

-- Variables
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

	MEM.State.totalTimePlayed = MEM.State.totalTimePlayed + timeLastCheck
	MEM.State.timePlayedThisLevel = MEM.State.timePlayedThisLevel + timeLastCheck

	sessionStartTime = currentTime
end

local function CheckInterval()
	Addon:PrintDebug("Timer triggered.")

	minutesPassed = minutesPassed + 1

	if MEM.Settings.event["interval-active"] and minutesPassed >= MEM.Settings.event["interval-timer"] then
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
		Addon:OpenCategory()
	else
		Addon:PrintDebug("These arguments are not accepted.")
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

		local dbInit = Utils:InitializeDatabase()
		Utils:InitializeMinimapButton()
		Options:Initialize()

		RequestTimePlayed()
		Utils:OpenSettingsOnLoading()

		C_Timer.NewTicker(60, CheckInterval)

		Addon:PrintDebug(string.format(
			"InitializeDatabase: key=%s, createdProfile=%s, createdProfileKey=%s, activeProfile=%s",
			tostring(dbInit.characterRealmKey), tostring(dbInit.createdProfile), tostring(dbInit.createdProfileKey), tostring(dbInit.activeProfile)
		))
		Addon:PrintDebug("Addon fully loaded.")
	end
end

function MementoFrame:TIME_PLAYED_MSG(_, totalTimePlayed, timePlayedThisLevel)
	Addon:PrintDebug(string.format(
		"Event 'TIME_PLAYED_MSG' fired. Payload: totalTimePlayed=%s, timePlayedThisLevel=%s",
		tostring(totalTimePlayed), tostring(timePlayedThisLevel)
	))

	MEM.State.totalTimePlayed = totalTimePlayed
	MEM.State.timePlayedThisLevel = timePlayedThisLevel

	sessionStartTime = GetTime()

	Addon:PrintDebug("Event 'TIME_PLAYED_MSG' completed.")
end

function MementoFrame:ACHIEVEMENT_EARNED(_, achievementID, alreadyEarned)
	Addon:PrintDebug(string.format(
		"Event 'ACHIEVEMENT_EARNED' fired. Payload: achievementID=%s, alreadyEarned=%s",
		tostring(achievementID), tostring(alreadyEarned)
	))

	local isGuildAchievement = select(12, GetAchievementInfo(achievementID))

	if not isGuildAchievement then
		if MEM.Settings.event["achievement-personal-active"] then
			TimePlayed()
			Capture:ScheduleTimer("AchievementPersonalEventHandler", MEM.Settings.event["achievement-personal-delay"] + fixDelay, achievementID, alreadyEarned)
		else
			Addon:PrintDebug("Event 'ACHIEVEMENT_EARNED' (Personal) completed. No screenshot requested.")
		end
	else
		if MEM.Settings.event["achievement-guild-active"] then
			TimePlayed()
			Capture:ScheduleTimer("AchievementGuildEventHandler", MEM.Settings.event["achievement-guild-delay"] + fixDelay, achievementID)
		else
			Addon:PrintDebug("Event 'ACHIEVEMENT_EARNED' (Guild) completed. No screenshot requested.")
		end
	end
end

function MementoFrame:CRITERIA_EARNED(_, achievementID, description)
	Addon:PrintDebug(string.format(
		"Event 'CRITERIA_EARNED' fired. Payload: achievementID=%s, description=%s",
		tostring(achievementID), tostring(description)
	))

	if MEM.Settings.event["achievement-criteria-active"] then
		TimePlayed()
		Capture:ScheduleTimer("CriteriaEventHandler", MEM.Settings.event["achievement-criteria-delay"] + fixDelay, achievementID, description)
	else
		Addon:PrintDebug("Event 'CRITERIA_EARNED' completed. No screenshot requested.")
	end
end

function MementoFrame:CHALLENGE_MODE_COMPLETED(_)
	Addon:PrintDebug("Event 'CHALLENGE_MODE_COMPLETED' fired. No payload.")

	if MEM.Settings.event["mythic-active"] then
		TimePlayed()
		Capture:ScheduleTimer("MythicEventHandler", MEM.Settings.event["mythic-delay"] + fixDelay)
	else
		Addon:PrintDebug("Event 'CHALLENGE_MODE_COMPLETED' completed. No screenshot requested.")
	end
end

function MementoFrame:PVP_MATCH_COMPLETE(_, winner, duration)
	Addon:PrintDebug(string.format(
		"Event 'PVP_MATCH_COMPLETE' fired. Payload: winner=%s, duration=%s",
		tostring(winner), tostring(duration)
	))

	local isArena = C_PvP.IsArena()
	local isBattleground = C_PvP.IsBattleground()
	local isSoloRBG = C_PvP.IsSoloRBG()
	local isInBrawl = C_PvP.IsInBrawl()

	if isArena then
		if MEM.Settings.event["pvp-arena-active"] then
			TimePlayed()
			Capture:ScheduleTimer("PvPArenaEventHandler", MEM.Settings.event["pvp-arena-delay"] + fixDelay)
		else
			Addon:PrintDebug("Event 'PVP_MATCH_COMPLETE' (Arena) completed. No screenshot requested.")
		end
	elseif isInBrawl then
		if MEM.Settings.event["pvp-brawl-active"] then
			if MEM.Settings.event["pvp-brawl-victory-only"] then
				if IsPlayerWinner(winner) then
					TimePlayed()
					Capture:ScheduleTimer("PvPBrawlEventHandler", MEM.Settings.event["pvp-brawl-delay"] + fixDelay)
				else
					Addon:PrintDebug("Player faction has lost the brawl. No screenshot requested.")
				end
			else
				TimePlayed()
				Capture:ScheduleTimer("PvPBrawlEventHandler", MEM.Settings.event["pvp-brawl-delay"] + fixDelay)
			end
		else
			Addon:PrintDebug("Event 'PVP_MATCH_COMPLETE' (Brawl) completed. No screenshot requested.")
		end
	elseif isBattleground or isSoloRBG then
		if MEM.Settings.event["pvp-battleground-active"] then
			if MEM.Settings.event["pvp-battleground-victory-only"] then
				if IsPlayerWinner(winner) then
					TimePlayed()
					Capture:ScheduleTimer("PvPBattlegroundEventHandler", MEM.Settings.event["pvp-battleground-delay"] + fixDelay)
				else
					Addon:PrintDebug("Player faction has lost the battleground. No screenshot requested.")
				end
			else
				TimePlayed()
				Capture:ScheduleTimer("PvPBattlegroundEventHandler", MEM.Settings.event["pvp-battleground-delay"] + fixDelay)
			end
		else
			Addon:PrintDebug("Event 'PVP_MATCH_COMPLETE' (Battleground) completed. No screenshot requested.")
		end
	else
		Addon:PrintDebug("Unknown PvP Event. No screenshot requested.")
	end
end

function MementoFrame:NEW_PET_ADDED(_, battlePetGUID)
	Addon:PrintDebug(string.format(
		"Event 'NEW_PET_ADDED' fired. Payload: battlePetGUID=%s",
		tostring(battlePetGUID)
	))

	if MEM.Settings.event["collection-pet-active"] then
		TimePlayed()
		Capture:ScheduleTimer("NewPetEventHandler", MEM.Settings.event["collection-pet-delay"] + fixDelay)
	else
		Addon:PrintDebug("Event 'NEW_PET_ADDED' completed. No screenshot requested.")
	end
end

function MementoFrame:NEW_MOUNT_ADDED(_, mountID)
	Addon:PrintDebug(string.format(
		"Event 'NEW_MOUNT_ADDED' fired. Payload: mountID=%s",
		tostring(mountID)
	))

	if MEM.Settings.event["collection-mount-active"] then
		TimePlayed()
		Capture:ScheduleTimer("NewMountEventHandler", MEM.Settings.event["collection-mount-delay"] + fixDelay)
	else
		Addon:PrintDebug("Event 'NEW_MOUNT_ADDED' completed. No screenshot requested.")
	end
end

function MementoFrame:NEW_TOY_ADDED(_, itemID)
	Addon:PrintDebug(string.format(
		"Event 'NEW_TOY_ADDED' fired. Payload: itemID=%s",
		tostring(itemID)
	))

	if MEM.Settings.event["collection-toy-active"] then
		TimePlayed()
		Capture:ScheduleTimer("NewToyEventHandler", MEM.Settings.event["collection-toy-delay"] + fixDelay)
	else
		Addon:PrintDebug("Event 'NEW_TOY_ADDED' completed. No screenshot requested.")
	end
end

function MementoFrame:NEW_HOUSING_ITEM_ACQUIRED(_, itemType, itemName, icon)
	Addon:PrintDebug(string.format(
		"Event 'NEW_HOUSING_ITEM_ACQUIRED' fired. Payload: itemType=%s, itemName=%s, icon=%s",
		tostring(itemType),	tostring(itemName),	tostring(icon)
	))

	if MEM.Settings.event["collection-housing-active"] then
		TimePlayed()
		Capture:ScheduleTimer("NewHousingItemEventHandler", MEM.Settings.event["collection-housing-delay"] + fixDelay)
	else
		Addon:PrintDebug("Event 'NEW_HOUSING_ITEM_ACQUIRED' completed. No screenshot requested.")
	end
end

function MementoFrame:PLAYER_ENTERING_WORLD(_, isInitialLogin, isReloadingUi)
	Addon:PrintDebug(string.format(
		"Event 'PLAYER_ENTERING_WORLD' fired. Payload: isInitialLogin=%s, isReloadingUi=%s",
		tostring(isInitialLogin), tostring(isReloadingUi)
	))

	if MEM.Settings.event["login-active"] and isInitialLogin then
		TimePlayed()
		Capture:ScheduleTimer("LoginEventHandler", MEM.Settings.event["login-delay"] + fixDelay)
	else
		Addon:PrintDebug("Event 'PLAYER_ENTERING_WORLD' completed. No screenshot requested.")
	end
end

function MementoFrame:PLAYER_DEAD(_)
	Addon:PrintDebug("Event 'PLAYER_DEAD' fired. No payload.")

	if MEM.Settings.event["death-active"] then
		TimePlayed()
		local inInstance = IsInInstance()

		if MEM.Settings.event["death-instance"] == 0 then
			Capture:ScheduleTimer("DeathEventHandler", MEM.Settings.event["death-delay"] + fixDelay)
		elseif inInstance and MEM.Settings.event["death-instance"] == 1 then
			Capture:ScheduleTimer("DeathEventHandler", MEM.Settings.event["death-delay"] + fixDelay)
		elseif not inInstance and MEM.Settings.event["death-instance"] == 2 then
			Capture:ScheduleTimer("DeathEventHandler", MEM.Settings.event["death-delay"] + fixDelay)
		else
			Addon:PrintDebug("Player died in the wrong area. No screenshot requested.")
		end
	else
		Addon:PrintDebug("Event 'PLAYER_DEAD' completed. No screenshot requested.")
	end
end

function MementoFrame:PLAYER_LEVEL_UP(_, level)
	Addon:PrintDebug(string.format(
		"Event 'PLAYER_LEVEL_UP' fired. Payload: level=%s",
		tostring(level)
	))

	if MEM.Settings.event["level-up-active"] then
		TimePlayed()
		Capture:ScheduleTimer("LevelUpEventHandler", MEM.Settings.event["level-up-delay"] + fixDelay, level)
	else
		Addon:PrintDebug("Event 'PLAYER_LEVEL_UP' completed. No screenshot requested.")
	end
end

function MementoFrame:ENCOUNTER_END(_, encounterID, encounterName, difficultyID, groupSize, success)
	Addon:PrintDebug(string.format(
		"Event 'ENCOUNTER_END' fired. Payload: encounterID=%s, encounterName=%s, difficultyID=%s, groupSize=%s, success=%s",
		tostring(encounterID), tostring(encounterName),	tostring(difficultyID),	tostring(groupSize), tostring(success)
	))

	local difficultyName, groupType = GetDifficultyInfo(difficultyID)
	local difficulty = "D" .. tostring(difficultyID)

	if groupType == "party" or groupType == "raid" or groupType == "scenario" then
		if success == 1 then
			local isActive = (groupType == "party" and MEM.Settings.event["encounter-victory-party-active"]) or
								(groupType == "raid" and MEM.Settings.event["encounter-victory-raid-active"]) or
								(groupType == "scenario" and MEM.Settings.event["encounter-victory-scenario-active"])

			local delay = (groupType == "party" and MEM.Settings.event["encounter-victory-party-delay"]) or
							(groupType == "raid" and MEM.Settings.event["encounter-victory-raid-delay"]) or
							(groupType == "scenario" and MEM.Settings.event["encounter-victory-scenario-delay"])

			local firstOnly = (groupType == "party" and MEM.Settings.event["encounter-victory-party-first"]) or
								(groupType == "raid" and MEM.Settings.event["encounter-victory-raid-first"]) or
								(groupType == "scenario" and MEM.Settings.event["encounter-victory-scenario-first"])

			if isActive then
				if not MEM.Data.bossKill[difficulty] then MEM.Data.bossKill[difficulty] = {} end

				if MEM.Data.bossKill[difficulty][encounterID] and firstOnly then
					Addon:PrintDebug("Encounter already killed. No screenshot requested.")
				else
					TimePlayed()
					Capture:ScheduleTimer("EncounterVictoryEventHandler", delay + fixDelay, encounterName, difficultyName, difficulty, encounterID)
				end
			else
				Addon:PrintDebug("Event 'ENCOUNTER_END' (Victory) completed. No screenshot requested.")
			end
		else
			local isActive = (groupType == "party" and MEM.Settings.event["encounter-wipe-party-active"]) or
								(groupType == "raid" and MEM.Settings.event["encounter-wipe-raid-active"]) or
								(groupType == "scenario" and MEM.Settings.event["encounter-wipe-scenario-active"])

			local delay = (groupType == "party" and MEM.Settings.event["encounter-wipe-party-delay"]) or
							(groupType == "raid" and MEM.Settings.event["encounter-wipe-raid-delay"]) or
							(groupType == "scenario" and MEM.Settings.event["encounter-wipe-scenario-delay"])

			if isActive then
				TimePlayed()
				Capture:ScheduleTimer("EncounterWipeEventHandler", delay + fixDelay, encounterName, difficultyName)
			else
				Addon:PrintDebug("Event 'ENCOUNTER_END' (Wipe) completed. No screenshot requested.")
			end
		end
	else
		Addon:PrintDebug(string.format(
			"Unknown groupType '%s'. No screenshot requested.",
			tostring(groupType)
		))
	end
end

function MementoFrame:DUEL_FINISHED(_)
	Addon:PrintDebug("Event 'DUEL_FINISHED' fired. No payload.")

	if MEM.Settings.event["pvp-duel-active"] then
		TimePlayed()
		Capture:ScheduleTimer("PvPDuelEventHandler", MEM.Settings.event["pvp-duel-delay"] + fixDelay)
	else
		Addon:PrintDebug("Event 'DUEL_FINISHED' completed. No screenshot requested.")
	end
end

function MementoFrame:NEW_RECIPE_LEARNED(_, recipeID, recipeLevel, baseRecipeID)
	Addon:PrintDebug(string.format(
		"Event 'NEW_RECIPE_LEARNED' fired. Payload: recipeID=%s, recipeLevel=%s, baseRecipeID=%s",
		tostring(recipeID),	tostring(recipeLevel), tostring(baseRecipeID)
	))

	if MEM.Settings.event["collection-recipe-active"] then
		TimePlayed()
		Capture:ScheduleTimer("NewRecipeEventHandler", MEM.Settings.event["collection-recipe-delay"] + fixDelay)
	else
		Addon:PrintDebug("Event 'NEW_RECIPE_LEARNED' completed. No screenshot requested.")
	end
end

--------------------------
--- Event Registration ---
--------------------------

MementoFrame:RegisterEvent("ADDON_LOADED")
MementoFrame:RegisterEvent("TIME_PLAYED_MSG")

if AWL.GAME_TYPE_VANILLA then
elseif AWL.GAME_TYPE_TBC then
elseif AWL.GAME_TYPE_MISTS then
	MementoFrame:RegisterEvent("ACHIEVEMENT_EARNED")
	MementoFrame:RegisterEvent("NEW_PET_ADDED")
	MementoFrame:RegisterEvent("NEW_MOUNT_ADDED")
	MementoFrame:RegisterEvent("NEW_TOY_ADDED")
elseif AWL.GAME_TYPE_MAINLINE then
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
