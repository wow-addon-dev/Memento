local addonName, MEM = ...

local L = MEM.Localization

local Utils = MEM.Utils
local Options = MEM.Options
local Screenshot = MEM.Screenshot

local fixDelay = 0.1
local lastEventTime = 0

local minuteTicker
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

    if minutesPassed >= MEM.options.general["interval-timer"] and MEM.options.general["interval-active"] then
		TimePlayed()

        Screenshot:ScheduleTimer("IntervalEventHandler", fixDelay)

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

        Utils:PrintDebug("Addon fully loaded.")
    end
end

function MementoFrame:TIME_PLAYED_MSG(_, totalTimePlayed, timePlayedThisLevel)
    Utils:PrintDebug("Event 'TIME_PLAYED_MSG' fired. Payload: totalTimePlayed=" .. tostring(totalTimePlayed) .. ", timePlayedThisLevel=" .. tostring(timePlayedThisLevel))

    totalTimePlayed = totalTimePlayed
    MEMdfd.timePlayedThisLevel = timePlayedThisLevel

    Utils:PrintDebug("Event 'TIME_PLAYED_MSG' completed.")
end

function MementoFrame:ACHIEVEMENT_EARNED(_, achievementID, alreadyEarned)
    Utils:PrintDebug("Event 'ENCOUNTER_START' fired. Payload: achievementID=" .. tostring(achievementID) .. ", alreadyEarned=" .. tostring(alreadyEarned))
end

function MementoFrame:PLAYER_ENTERING_WORLD(_, isInitialLogin, isReloadingUi)
    Utils:PrintDebug("Event 'ENCOUNTER_START' fired. Payload: isInitialLogin=" .. tostring(isInitialLogin) .. ", isReloadingUi=" .. tostring(isReloadingUi))
end

MementoFrame:RegisterEvent("ADDON_LOADED")
MementoFrame:RegisterEvent("TIME_PLAYED_MSG")

if MEM.GAME_TYPE_VANILLA then

elseif MEM.GAME_TYPE_TBC then

elseif MEM.GAME_TYPE_MISTS then

elseif MEM.GAME_TYPE_MAINLINE then

end

MementoFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
MementoFrame:SetScript("OnEvent", MementoFrame.OnEvent)

SLASH_Horatum1, SLASH_Horatum2 = '/mem', '/memento'

SlashCmdList["Memento"] = SlashCommand
