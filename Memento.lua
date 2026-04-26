local addonName, MEM = ...

local L = MEM.Localization

local Utils = MEM.Utils
local Options = MEM.Options
local Capture = MEM.Capture

local fixDelay = 0.1
local minutesPassed = 0
local sessionStartTime = 0

--------------
--- Frames ---
--------------

local MementoFrame = CreateFrame("Frame", "Memento")

----------------------
--- Local Funtions ---
----------------------

local function TimePlayed()
    local currentTime = GetTime()
   	local timeSinceLastCheck = currentTime - sessionStartTime

	MEM.var.totalTimePlayed = MEM.var.totalTimePlayed + timeSinceLastCheck
	MEM.var.timePlayedThisLevel = MEM.var.timePlayedThisLevel + timeSinceLastCheck

	sessionStartTime = currentTime
end

local function CheckInterval()
    Utils:PrintDebug("Timer triggered.")

    minutesPassed = minutesPassed + 1

    if MEM.options.event["interval-active"] and minutesPassed >= MEM.options.event["interval-timer"] then
        TimePlayed()

        Capture:ScheduleTimer("IntervalEventHandler", fixDelay)

        minutesPassed = 0
    end
end

local function SlashCommand(msg, editbox)
    if not msg or msg:trim() == "" then
        Settings.OpenToCategory(MEM.MAIN_CATEGORY_ID)
    else
        Utils:PrintDebug("These arguments are not accepted.")
    end
end

---------------------
--- Main Funtions ---
---------------------

function MementoFrame:OnEvent(event, ...)
    self[event](self, event, ...)
end

function MementoFrame:ADDON_LOADED(_, addOnName)
    if addOnName == addonName then
        Utils:InitializeDatabase()
        Utils:InitializeMinimapButton()
        Options:Initialize()

		RequestTimePlayed()

        local ticker = C_Timer.NewTicker(60, CheckInterval)

        Utils:PrintDebug("Addon fully loaded.")
    end
end

function MementoFrame:TIME_PLAYED_MSG(_, totalTimePlayed, timePlayedThisLevel)
    Utils:PrintDebug("Event 'TIME_PLAYED_MSG' fired. Payload: totalTimePlayed=" .. tostring(totalTimePlayed) .. ", timePlayedThisLevel=" .. tostring(timePlayedThisLevel))

    MEM.var.totalTimePlayed = totalTimePlayed
    MEM.var.timePlayedThisLevel = timePlayedThisLevel

	sessionStartTime = GetTime()

    Utils:PrintDebug("Event 'TIME_PLAYED_MSG' completed.")
end

function MementoFrame:ACHIEVEMENT_EARNED(_, achievementID, alreadyEarned)
    Utils:PrintDebug("Event 'ACHIEVEMENT_EARNED' fired. Payload: achievementID=" .. tostring(achievementID) .. ", alreadyEarned=" .. tostring(alreadyEarned))

    local isGuildAchievement = select(12, GetAchievementInfo(achievementID))

    if not isGuildAchievement then
        if MEM.options.event["achievement-personal-active"] then
            TimePlayed()
            Capture:ScheduleTimer("AchievementPersonalEventHandler", MEM.options.event["achievement-personal-delay"] + fixDelay, achievementID, alreadyEarned)
        else
            Utils:PrintDebug("Event 'ACHIEVEMENT_EARNED' (Personal) completed. No screenshot requested.")
        end
    else
        if MEM.options.event["achievement-guild-active"] then
            TimePlayed()
            Capture:ScheduleTimer("AchievementGuildEventHandler", MEM.options.event["achievement-guild-delay"] + fixDelay, achievementID)
        else
            Utils:PrintDebug("Event 'ACHIEVEMENT_EARNED' (Guild) completed. No screenshot requested.")
        end
    end
end

function MementoFrame:CRITERIA_EARNED(_, achievementID, description)
    Utils:PrintDebug("Event 'CRITERIA_EARNED' fired. Payload: achievementID=" .. tostring(achievementID) .. ", description=" .. tostring(description))

    if MEM.options.event["achievement-criteria-active"] then
        TimePlayed()
        Capture:ScheduleTimer("CriteriaEventHandler", MEM.options.event["achievement-criteria-delay"] + fixDelay, achievementID, description)
    else
        Utils:PrintDebug("Event 'CRITERIA_EARNED' completed. No screenshot requested.")
    end
end

function MementoFrame:CHALLENGE_MODE_COMPLETED(_)
    Utils:PrintDebug("Event 'CHALLENGE_MODE_COMPLETED' fired. No payload.")

    if MEM.options.event["mythic-active"] then
        TimePlayed()
        Capture:ScheduleTimer("MythicEventHandler", MEM.options.event["mythic-delay"] + fixDelay)
    else
        Utils:PrintDebug("Event 'CHALLENGE_MODE_COMPLETED' completed. No screenshot requested.")
    end
end

function MementoFrame:PVP_MATCH_COMPLETE(_, winner, duration)
    Utils:PrintDebug("Event 'PVP_MATCH_COMPLETE' fired. Payload: winner=" .. tostring(winner) .. ", duration=" .. tostring(duration))

    local isArena = C_PvP.IsArena()
    local isBattleground = C_PvP.IsBattleground()
    local isSoloRBG = C_PvP.IsSoloRBG()
    local isInBrawl = C_PvP.IsInBrawl()
    local playerFaction = UnitFactionGroup("player")

    if isArena then
        if MEM.options.event["pvp-arena-active"] then
            TimePlayed()
            Capture:ScheduleTimer("PvPArenaEventHandler", MEM.options.event["pvp-arena-delay"] + fixDelay)
        else
            Utils:PrintDebug("Event 'PVP_MATCH_COMPLETE' (Arena) completed. No screenshot requested.")
        end
    elseif isBattleground or isSoloRBG then
        if MEM.options.event["pvp-battleground-active"] then
            if MEM.options.event["pvp-battleground-victory-only"] then
                if (playerFaction == "Alliance" and winner == 1) or (playerFaction == "Horde" and winner == 0) then
                    TimePlayed()
                    Capture:ScheduleTimer("PvPBattlegroundEventHandler", MEM.options.event["pvp-battleground-delay"] + fixDelay)
                else
                    Utils:PrintDebug("Player faction has lost the battleground. No screenshot requested.")
                end
            else
                TimePlayed()
                Capture:ScheduleTimer("PvPBattlegroundEventHandler", MEM.options.event["pvp-battleground-delay"] + fixDelay)
            end
        else
            Utils:PrintDebug("Event 'PVP_MATCH_COMPLETE' (Battleground) completed. No screenshot requested.")
        end
    elseif isInBrawl then
        if MEM.options.event["pvp-brawl-active"] then
            if MEM.options.event["pvp-brawl-victory-only"] then
                if (playerFaction == "Alliance" and winner == 1) or (playerFaction == "Horde" and winner == 0) then
                    TimePlayed()
                    Capture:ScheduleTimer("PvPBrawlEventHandler", MEM.options.event["pvp-brawl-delay"] + fixDelay)
                else
                    Utils:PrintDebug("Player faction has lost the brawl. No screenshot requested.")
                end
            else
                TimePlayed()
                Capture:ScheduleTimer("PvPBrawlEventHandler", MEM.options.event["pvp-brawl-delay"] + fixDelay)
            end
        else
            Utils:PrintDebug("Event 'PVP_MATCH_COMPLETE' (Brawl) completed. No screenshot requested.")
        end
    else
        Utils:PrintDebug("Unknown PvP Event. No screenshot requested.")
    end
end

function MementoFrame:NEW_PET_ADDED(_, battlePetGUID)
    Utils:PrintDebug("Event 'NEW_PET_ADDED' fired. Payload: battlePetGUID=" .. tostring(battlePetGUID))

    if MEM.options.event["collection-pet-active"] then
        TimePlayed()
        Capture:ScheduleTimer("NewPetEventHandler", MEM.options.event["collection-pet-delay"] + fixDelay)
    else
        Utils:PrintDebug("Event 'NEW_PET_ADDED' completed. No screenshot requested.")
    end
end

function MementoFrame:NEW_MOUNT_ADDED(_, mountID)
    Utils:PrintDebug("Event 'NEW_MOUNT_ADDED' fired. Payload: mountID=" .. tostring(mountID))

    if MEM.options.event["collection-mount-active"] then
        TimePlayed()
        Capture:ScheduleTimer("NewMountEventHandler", MEM.options.event["collection-mount-delay"] + fixDelay)
    else
        Utils:PrintDebug("Event 'NEW_MOUNT_ADDED' completed. No screenshot requested.")
    end
end

function MementoFrame:NEW_TOY_ADDED(_, itemID)
    Utils:PrintDebug("Event 'NEW_TOY_ADDED' fired. Payload: itemID=" .. tostring(itemID))

    if MEM.options.event["collection-toy-active"] then
        TimePlayed()
        Capture:ScheduleTimer("NewToyEventHandler", MEM.options.event["collection-toy-delay"] + fixDelay)
    else
        Utils:PrintDebug("Event 'NEW_TOY_ADDED' completed. No screenshot requested.")
    end
end

function MementoFrame:NEW_HOUSING_ITEM_ACQUIRED(_, itemType, itemName, icon)
    Utils:PrintDebug("Event 'NEW_HOUSING_ITEM_ACQUIRED' fired. Payload: itemType=" .. tostring(itemType) .. ", itemName=" .. tostring(itemName) .. ", icon=" .. tostring(icon))

    if MEM.options.event["collection-housing-active"] then
        TimePlayed()
        Capture:ScheduleTimer("NewHousingItemEventHandler", MEM.options.event["collection-housing-delay"] + fixDelay)
    else
        Utils:PrintDebug("Event 'NEW_HOUSING_ITEM_ACQUIRED' completed. No screenshot requested.")
    end
end

function MementoFrame:PLAYER_ENTERING_WORLD(_, isInitialLogin, isReloadingUi)
    Utils:PrintDebug("Event 'PLAYER_ENTERING_WORLD' fired. Payload: isInitialLogin=" .. tostring(isInitialLogin) .. ", isReloadingUi=" .. tostring(isReloadingUi))

    if MEM.options.event["login-active"] and isInitialLogin then
        TimePlayed()
        Capture:ScheduleTimer("LoginEventHandler", MEM.options.event["login-delay"] + fixDelay)
    else
        Utils:PrintDebug("Event 'PLAYER_ENTERING_WORLD' completed. No screenshot requested.")
    end
end

function MementoFrame:PLAYER_DEAD(_)
    Utils:PrintDebug("Event 'PLAYER_DEAD' fired. No payload.")

    if MEM.options.event["death-active"] then
        TimePlayed()
        local inInstance, instanceType = IsInInstance()

        if MEM.options.event["death-instance"] == 0 then
            Capture:ScheduleTimer("DeathEventHandler", MEM.options.event["death-delay"] + fixDelay)
        elseif inInstance and MEM.options.event["death-instance"] == 1 then
            Capture:ScheduleTimer("DeathEventHandler", MEM.options.event["death-delay"] + fixDelay)
        elseif not inInstance and MEM.options.event["death-instance"] == 2 then
            Capture:ScheduleTimer("DeathEventHandler", MEM.options.event["death-delay"] + fixDelay)
        else
            Utils:PrintDebug("Player died in the wrong area. No screenshot requested.")
        end
    else
        Utils:PrintDebug("Event 'PLAYER_DEAD' completed. No screenshot requested.")
    end
end

function MementoFrame:PLAYER_LEVEL_UP(_, level)
    Utils:PrintDebug("Event 'PLAYER_LEVEL_UP' fired. Payload: level=" .. tostring(level))

    if MEM.options.event["level-up-active"] then
        TimePlayed()
        Capture:ScheduleTimer("LevelUpEventHandler", MEM.options.event["level-up-delay"] + fixDelay)
    else
        Utils:PrintDebug("Event 'PLAYER_LEVEL_UP' completed. No screenshot requested.")
    end
end

function MementoFrame:ENCOUNTER_END(_, encounterID, encounterName, difficultyID, groupSize, success)
    Utils:PrintDebug("Event 'ENCOUNTER_END' fired. Payload: encounterID=" .. tostring(encounterID) .. ", encounterName=" .. tostring(encounterName) .. ", difficultyID=" .. tostring(difficultyID) .. ", groupSize=" .. tostring(groupSize) .. ", success=" .. tostring(success))

    local difficultyName, groupType = GetDifficultyInfo(difficultyID)
    local difficulty = "D" .. tostring(difficultyID)

    if groupType == "party" or groupType == "raid" or groupType == "scenario" then
        if success == 1 then
            local isActive = (groupType == "party" and MEM.options.event["encounter-victory-party-active"]) or
                             (groupType == "raid" and MEM.options.event["encounter-victory-raid-active"]) or
                             (groupType == "scenario" and MEM.options.event["encounter-victory-scenario-active"])

            local delay = (groupType == "party" and MEM.options.event["encounter-victory-party-delay"]) or
                          (groupType == "raid" and MEM.options.event["encounter-victory-raid-delay"]) or
                          (groupType == "scenario" and MEM.options.event["encounter-victory-scenario-delay"]) or 3

            local firstOnly = (groupType == "party" and MEM.options.event["encounter-victory-party-first"]) or
                              (groupType == "raid" and MEM.options.event["encounter-victory-raid-first"]) or
                              (groupType == "scenario" and MEM.options.event["encounter-victory-scenario-first"])

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
            local isActive = (groupType == "party" and MEM.options.event["encounter-wipe-party-active"]) or
                             (groupType == "raid" and MEM.options.event["encounter-wipe-raid-active"]) or
                             (groupType == "scenario" and MEM.options.event["encounter-wipe-scenario-active"])

            local delay = (groupType == "party" and MEM.options.event["encounter-wipe-party-delay"]) or
                          (groupType == "raid" and MEM.options.event["encounter-wipe-raid-delay"]) or
                          (groupType == "scenario" and MEM.options.event["encounter-wipe-scenario-delay"]) or 3

            if isActive then
                TimePlayed()
                Capture:ScheduleTimer("EncounterWipeEventHandler", delay + fixDelay, encounterName, difficultyName)
            else
                Utils:PrintDebug("Event 'ENCOUNTER_END' (Wipe) completed. No screenshot requested.")
            end
        end
    else
        Utils:PrintDebug("Unknown groupType '" .. tostring(groupType) .. "'. No screenshot requested.")
    end
end

function MementoFrame:DUEL_FINISHED(_)
    Utils:PrintDebug("Event 'DUEL_FINISHED' fired. No payload.")

    if MEM.options.event["pvp-duel-active"] then
        TimePlayed()
        Capture:ScheduleTimer("PvPDuelEventHandler", MEM.options.event["pvp-duel-delay"] + fixDelay)
    else
        Utils:PrintDebug("Event 'DUEL_FINISHED' completed. No screenshot requested.")
    end
end

function MementoFrame:NEW_RECIPE_LEARNED(_, recipeID, recipeLevel, baseRecipeID)
    Utils:PrintDebug("Event 'NEW_RECIPE_LEARNED' fired. Payload: recipeID=" .. tostring(recipeID) .. ", recipeLevel=" .. tostring(recipeLevel) .. ", baseRecipeID=" .. tostring(baseRecipeID))

    if MEM.options.event["collection-recipe-active"] then
        TimePlayed()
        Capture:ScheduleTimer("NewRecipeEventHandler", MEM.options.event["collection-recipe-delay"] + fixDelay)
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
    MementoFrame:RegisterEvent("NEW_PET_ADDED")
    MementoFrame:RegisterEvent("NEW_MOUNT_ADDED")
    MementoFrame:RegisterEvent("NEW_TOY_ADDED")
    MementoFrame:RegisterEvent("NEW_HOUSING_ITEM_ACQUIRED")
end

MementoFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
MementoFrame:RegisterEvent("PLAYER_DEAD")
MementoFrame:RegisterEvent("PLAYER_LEVEL_UP")
MementoFrame:RegisterEvent("ENCOUNTER_END")
MementoFrame:RegisterEvent("DUEL_FINISHED")
MementoFrame:RegisterEvent("NEW_RECIPE_LEARNED")

MementoFrame:SetScript("OnEvent", MementoFrame.OnEvent)

SLASH_Memento1, SLASH_Memento2 = '/mem', '/memento'
SlashCmdList["Memento"] = SlashCommand
