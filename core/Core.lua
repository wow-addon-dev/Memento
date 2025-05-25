local addonName, Memento = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local screenshotQueue = {}
local lastScreenshotTime = 0
local PROCESS_INTERVAL = 0.1
local SCREENSHOT_DELAY = 1

----------------------
--- Local funtions ---
----------------------

local function createMessageFrame(frame)
    local font

    frame = CreateFrame("Frame")
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
    font = frame.textTop:GetFont()
    frame.textTop:SetFont(tostring(font), 7)
    frame.textTop:SetText(L["screen.message"])

    frame.textBottom = frame:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")
    frame.textBottom:ClearAllPoints()
    frame.textBottom:SetPoint("CENTER", 0, -6)
    font = frame.textBottom:GetFont()
    frame.textBottom:SetFont(tostring(font), 7)
    frame.textBottom:SetText(tostring(date("%d/%m/%y %H:%M:%S", GetServerTime())))

    return frame
end

-----------------------
--- Public funtions ---
-----------------------

function Memento:TakeScreenshot(event)
    if self.db.profile.options.ui then
        if not InCombatLockdown() then
            local frame = CreateFrame("Frame")

            local status, err = pcall(function ()
                UIParent:Hide()

                frame = createMessageFrame(frame)
                frame:Show()

                C_Timer.After(0.1, function()
                    Screenshot()
                end)

                C_Timer.After(0.2, function()
                    UIParent:Show()
                    frame:Hide()
                end)

                self:PrintDebug("Screenshot without UI taken.")
            end)

            if not status then
                UIParent:Show()
                frame:Hide()

                self:PrintDebug("Method TakeScreenshot() (without UI) aborted with exception: " .. err)

                Screenshot()

                self:PrintDebug("Screenshot taken.")
            end
        else
            self:PrintDebug("No screenshot is possible in combat without ui.")
            self:PrintDebug("Screenshot taken.")
        end
    else
        Screenshot()

        self:PrintDebug("Screenshot taken.")
    end

    if event == Memento.EVENT_ACHIEVEMENT_EARNED_PERSONAL then
        self.dbStatstic.char.events.achievement.personal.count = self.dbStatstic.char.events.achievement.personal.count + 1
        self.dbStatstic.global.events.achievement.personal.count = self.dbStatstic.global.events.achievement.personal.count + 1
        self:PrintDebug("Counter for 'ACHIEVEMENT_EARNED' (Personal) increased by one.")
    elseif event == Memento.EVENT_ACHIEVEMENT_CRITERIA_EARNED then
        self.dbStatstic.char.events.achievement.criteria.count = self.dbStatstic.char.events.achievement.criteria.count + 1
        self.dbStatstic.global.events.achievement.criteria.count = self.dbStatstic.global.events.achievement.criteria.count + 1
        self:PrintDebug("Counter for 'CRITERIA_EARNED' increased by one.")
    elseif event == Memento.EVENT_ACHIEVEMENT_EARNED_GUILD then
        self.dbStatstic.char.events.achievement.guild.count = self.dbStatstic.char.events.achievement.guild.count + 1
        self.dbStatstic.global.events.achievement.guild.count = self.dbStatstic.global.events.achievement.guild.count + 1
        self:PrintDebug("Counter for 'ACHIEVEMENT_EARNED' (Guild) increased by one.")
    elseif event == Memento.EVENT_ENCOUNTER_END_VICTORY then
        self.dbStatstic.char.events.encounter.victory.count = self.dbStatstic.char.events.encounter.victory.count + 1
        self.dbStatstic.global.events.encounter.victory.count = self.dbStatstic.global.events.encounter.victory.count + 1
        self:PrintDebug("Counter for 'ENCOUNTER_END' (Victory) increased by one.")
    elseif event == Memento.EVENT_ENCOUNTER_END_WIPE then
        self.dbStatstic.char.events.encounter.wipe.count = self.dbStatstic.char.events.encounter.wipe.count + 1
        self.dbStatstic.global.events.encounter.wipe.count = self.dbStatstic.global.events.encounter.wipe.count + 1
        self:PrintDebug("Counter for 'ENCOUNTER_END' (Wipe) increased by one.")
    elseif event == Memento.EVENT_DUEL_FINISHED then
        self.dbStatstic.char.events.pvp.duel.count = self.dbStatstic.char.events.pvp.duel.count + 1
        self.dbStatstic.global.events.pvp.duel.count = self.dbStatstic.global.events.pvp.duel.count + 1
        self:PrintDebug("Counter for 'DUEL_FINISHED' increased by one.")
    elseif event == Memento.EVENT_PVP_MATCH_COMPLETE_ARENA then
        self.dbStatstic.char.events.pvp.arena.count = self.dbStatstic.char.events.pvp.arena.count + 1
        self.dbStatstic.global.events.pvp.arena.count = self.dbStatstic.global.events.pvp.arena.count + 1
        self:PrintDebug("Counter for 'PVP_MATCH_COMPLETE' (Arena) increased by one.")
    elseif event == Memento.EVENT_PVP_MATCH_COMPLETE_BATTLEGROUND then
        self.dbStatstic.char.events.pvp.battleground.count = self.dbStatstic.char.events.pvp.battleground.count + 1
        self.dbStatstic.global.events.pvp.battleground.count = self.dbStatstic.global.events.pvp.battleground.count + 1
        self:PrintDebug("Counter for 'PVP_MATCH_COMPLETE' (Battleground) increased by one.")
    elseif event == Memento.EVENT_PVP_MATCH_COMPLETE_BRAWL then
        self.dbStatstic.char.events.pvp.brawl.count = self.dbStatstic.char.events.pvp.brawl.count + 1
        self.dbStatstic.global.events.pvp.brawl.count = self.dbStatstic.global.events.pvp.brawl.count + 1
        self:PrintDebug("Counter for 'PVP_MATCH_COMPLETE' (Brawl) increased by one.")
    elseif event == Memento.EVENT_PLAYER_LEVEL_UP then
        self.dbStatstic.char.events.levelUp.count = self.dbStatstic.char.events.levelUp.count + 1
        self.dbStatstic.global.events.levelUp.count = self.dbStatstic.global.events.levelUp.count + 1
        self:PrintDebug("Counter for 'PLAYER_LEVEL_UP' increased by one.")
    elseif event == Memento.EVENT_PLAYER_DEAD then
        self.dbStatstic.char.events.death.count = self.dbStatstic.char.events.death.count + 1
        self.dbStatstic.global.events.death.count = self.dbStatstic.global.events.death.count + 1
        self:PrintDebug("Counter for 'PLAYER_DEAD' increased by one.")
    elseif event == Memento.EVENT_PLAYER_LOGIN then
        self.dbStatstic.char.events.login.count = self.dbStatstic.char.events.login.count + 1
        self.dbStatstic.global.events.login.count = self.dbStatstic.global.events.login.count + 1
        self:PrintDebug("Counter for 'PLAYER_LOGIN' increased by one.")
    else
        self:PrintDebug("No counter was increased.")
    end
end
