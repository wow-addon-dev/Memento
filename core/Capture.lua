local addonName, MEM = ...

local L = MEM.Localization

local Utils = MEM.Utils

local Capture = {}

-----------------------
--- Local Functions ---
-----------------------

local function CreateMessageFrame()
    local frame = CreateFrame("Frame")
    frame:ClearAllPoints()
    frame:SetPoint("BOTTOM", 0, 100)
    frame:SetSize(164, 41)

    frame.background = frame:CreateTexture(nil, "BACKGROUND")
    frame.background:ClearAllPoints()
    frame.background:SetAllPoints(frame)
    frame.background:SetTexture(612384)

    frame.textTop = frame:CreateFontString(nil, "OVERLAY", "GameFontBlackTiny")
    frame.textTop:ClearAllPoints()
    frame.textTop:SetPoint("CENTER", 0, 5)
    frame.textTop:SetFont(tostring(frame.textTop:GetFont()), 7)
    frame.textTop:SetText(L["capture.message"])

    frame.textBottom = frame:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")
    frame.textBottom:ClearAllPoints()
    frame.textBottom:SetPoint("CENTER", 0, -6)
    frame.textBottom:SetFont(tostring(frame.textBottom:GetFont()), 7)
    frame.textBottom:SetText(tostring(date("%d/%m/%y %H:%M:%S", GetServerTime())))

    return frame
end

local function TakeScreenshot()
    if MEM.options.general["hide-ui"] then
        if not InCombatLockdown() then
            local frame

            local status, err = pcall(function ()
                UIParent:Hide()

                frame = CreateMessageFrame()
                frame:Show()

                C_Timer.After(0.1, function()
                    Screenshot()
                end)

                C_Timer.After(0.2, function()
                    UIParent:Show()
                    frame:Hide()
                end)

                Utils:PrintDebug("Screenshot without UI taken.")
            end)

            if not status then
                UIParent:Show()
                frame:Hide()

                Utils:PrintDebug("Method TakeScreenshot() (without UI) aborted with exception: " .. err)

                Screenshot()

                Utils:PrintDebug("Screenshot taken.")
            end
        else
            Utils:PrintDebug("No screenshot is possible in combat without ui.")
            Utils:PrintDebug("Screenshot taken.")
        end
    else
        Screenshot()

        Utils:PrintDebug("Screenshot taken.")
    end
end

local function AchievementPersonalEventHandler(achievementID, alreadyEarned)
    if not alreadyEarned then
        Utils:PrintMessage(L["chat.event.achievement.personal.new"]:format(GetAchievementLink(achievementID)))
        TakeScreenshot()
    elseif MEM.options.event["achievement-personal-exist"] then
        Utils:PrintMessage(L["chat.event.achievement.personal.exist"]:format(GetAchievementLink(achievementID)))
        TakeScreenshot()
    else
        Utils:PrintDebug("The achievement ".. GetAchievementLink(achievementID) .. " has already been reached by another character. No screenshot requested.")
    end
end

local function AchievementGuildEventHandler(achievementID)
    local name = select(2, GetAchievementInfo(achievementID))

    Utils:PrintMessage(L["chat.event.achievement.guild.new"]:format(name))
    TakeScreenshot()
end

local function CriteriaEventHandler(achievementID, description)
    Utils:PrintMessage(L["chat.event.achievement.criteria.new"]:format(GetAchievementLink(achievementID), description))
    TakeScreenshot()
end

local function EncounterVictoryEventHandler(encounterName, difficultyName, difficulty, encounterID)
    Utils:PrintMessage(L["chat.event.encounter.victory.new"]:format(encounterName, difficultyName))
    TakeScreenshot()

    if not MEM.data.bossKill[difficulty] then MEM.data.bossKill[difficulty] = {} end

    MEM.data.bossKill[difficulty][encounterID] = true
end

local function EncounterWipeEventHandler(encounterName, difficultyName)
    Utils:PrintMessage(L["chat.event.encounter.wipe.new"]:format(encounterName, difficultyName))
    TakeScreenshot()
end

local function PvPDuelEventHandler()
    Utils:PrintMessage(L["chat.event.pvp.duel.new"])
    TakeScreenshot()
end

local function PvPArenaEventHandler()
    Utils:PrintMessage(L["chat.event.pvp.arena.new"])
    TakeScreenshot()
end

local function PvPBattlegroundEventHandler()
    Utils:PrintMessage(L["chat.event.pvp.battleground.new"])
    TakeScreenshot()
end

local function PvPBrawlEventHandler()
    Utils:PrintMessage(L["chat.event.pvp.brawl.new"])
    TakeScreenshot()
end

local function NewPetEventHandler()
    Utils:PrintMessage(L["chat.event.warband-collection.new-pet.new"])
    TakeScreenshot()
end

local function NewMountEventHandler()
    Utils:PrintMessage(L["chat.event.warband-collection.new-mount.new"])
    TakeScreenshot()
end

local function NewToyEventHandler()
    Utils:PrintMessage(L["chat.event.warband-collection.new-toy.new"])
    TakeScreenshot()
end

local function NewRecipeEventHandler()
    Utils:PrintMessage(L["chat.event.warband-collection.new-recipe.new"])
    TakeScreenshot()
end

local function NewHousingItemEventHandler()
    Utils:PrintMessage(L["chat.event.warband-collection.new-housing-item.new"])
    TakeScreenshot()
end

local function LoginEventHandler()
    Utils:PrintMessage(L["chat.event.login.new"])
    TakeScreenshot()
end

local function LevelUpEventHandler(level)
    Utils:PrintMessage(L["chat.event.level-up.new"]:format(level))
    TakeScreenshot()
end

local function DeathEventHandler()
    Utils:PrintMessage(L["chat.event.death.new"])
    TakeScreenshot()
end

local function MythicEventHandler()
    Utils:PrintMessage(L["chat.event.mythic.new"])
    TakeScreenshot()
end

local function IntervalEventHandler()
    Utils:PrintMessage(L["chat.event.interval.new"])
    TakeScreenshot()
end

local HandlerTable = {
    ["AchievementPersonalEventHandler"] = AchievementPersonalEventHandler,
    ["AchievementGuildEventHandler"]    = AchievementGuildEventHandler,
    ["CriteriaEventHandler"]            = CriteriaEventHandler,
    ["EncounterVictoryEventHandler"]    = EncounterVictoryEventHandler,
    ["EncounterWipeEventHandler"]       = EncounterWipeEventHandler,
    ["PvPDuelEventHandler"]             = PvPDuelEventHandler,
    ["PvPArenaEventHandler"]            = PvPArenaEventHandler,
    ["PvPBattlegroundEventHandler"]     = PvPBattlegroundEventHandler,
    ["PvPBrawlEventHandler"]            = PvPBrawlEventHandler,
    ["NewPetEventHandler"]              = NewPetEventHandler,
    ["NewMountEventHandler"]            = NewMountEventHandler,
    ["NewToyEventHandler"]              = NewToyEventHandler,
    ["NewRecipeEventHandler"]           = NewRecipeEventHandler,
    ["NewHousingItemEventHandler"]      = NewHousingItemEventHandler,
    ["LoginEventHandler"]               = LoginEventHandler,
    ["LevelUpEventHandler"]             = LevelUpEventHandler,
    ["DeathEventHandler"]               = DeathEventHandler,
    ["MythicEventHandler"]              = MythicEventHandler,
    ["IntervalEventHandler"]            = IntervalEventHandler
}

---------------------
--- Main Funtions ---
---------------------

function Capture:ScheduleTimer(handler, delay, ...)
    local args = {...}

    C_Timer.After(delay, function()
        if HandlerTable[handler] then
            HandlerTable[handler](unpack(args))
        else
            Utils:PrintDebug("Handler '" .. tostring(handler) .. "' not found.")
        end
    end)
end

MEM.Capture = Capture
