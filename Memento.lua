local addonName, MEM = ...

local L = MEM.Localization

local Utils = MEM.Utils
local Options = MEM.Options
local Capture = MEM.Capture

local fixDelay = 0.1
local lastEventTime = 0
local minutesPassed = 0

--------------
--- Frames ---
--------------

local MementoFrame = CreateFrame("Frame", "Memento")

----------------------
--- Local Funtions ---
----------------------

local function TimePlayed()
    local currentTime = GetTime()

    if currentTime - lastEventTime >= 5 and MEM.options.general["notification"] and (MEM.options.general["notification-class"] or MEM.options.general["notification-time-played"]) then
        lastEventTime = currentTime

        RequestTimePlayed()
    end
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

		local ticker = C_Timer.NewTicker(60, CheckInterval)

        Utils:PrintDebug("Addon fully loaded.")
    end
end

function MementoFrame:TIME_PLAYED_MSG(_, totalTimePlayed, timePlayedThisLevel)
    Utils:PrintDebug("Event 'TIME_PLAYED_MSG' fired. Payload: totalTimePlayed=" .. tostring(totalTimePlayed) .. ", timePlayedThisLevel=" .. tostring(timePlayedThisLevel))

    MEM.var.totalTimePlayed = totalTimePlayed
    MEM.var.timePlayedThisLevel = timePlayedThisLevel

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

function MementoFrame:PLAYER_ENTERING_WORLD(_, isInitialLogin, isReloadingUi)
    Utils:PrintDebug("Event 'PLAYER_ENTERING_WORLD' fired. Payload: isInitialLogin=" .. tostring(isInitialLogin) .. ", isReloadingUi=" .. tostring(isReloadingUi))

	if MEM.options.event["login-active"] and isInitialLogin then
		TimePlayed()

        Capture:ScheduleTimer("LoginEventHandler", MEM.options.event["login-delay"] + fixDelay)
    else
        Utils:PrintDebug("Event 'PLAYER_ENTERING_WORLD' completed. No screenshot requested.")
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

function MementoFrame:CHALLENGE_MODE_COMPLETED(_)
    Utils:PrintDebug("Event 'CHALLENGE_MODE_COMPLETED' fired. No payload.")

	if MEM.options.event["mythic-active"] then
		TimePlayed()

		Capture:ScheduleTimer("MythicEventHandler", MEM.options.event["mythic-delay"] + fixDelay)
	else
		Utils:PrintDebug("Event 'CHALLENGE_MODE_COMPLETED' completed. No screenshot requested.")
	end
end

MementoFrame:RegisterEvent("ADDON_LOADED")
MementoFrame:RegisterEvent("TIME_PLAYED_MSG")

if MEM.GAME_TYPE_VANILLA then

elseif MEM.GAME_TYPE_TBC then

elseif MEM.GAME_TYPE_MISTS then
	MementoFrame:RegisterEvent("ACHIEVEMENT_EARNED")
elseif MEM.GAME_TYPE_MAINLINE then
	MementoFrame:RegisterEvent("ACHIEVEMENT_EARNED")
	MementoFrame:RegisterEvent("CRITERIA_EARNED")
	MementoFrame:RegisterEvent("CHALLENGE_MODE_COMPLETED")
end

MementoFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
MementoFrame:SetScript("OnEvent", MementoFrame.OnEvent)

SLASH_Memento1, SLASH_Memento2 = '/mem', '/memento'

SlashCmdList["Memento"] = SlashCommand
