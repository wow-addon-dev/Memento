local addonName, Memento = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

-----------------------
--- Public funtions ---
-----------------------

function Memento:PrintMessage(msg)
    if self.db.profile.options.notification.active then
        DEFAULT_CHAT_FRAME:AddMessage(Memento_MarkNormalFont("Memento: ") .. msg)

        if self.db.profile.options.notification.class then
            local className = UnitClass("player")
            DEFAULT_CHAT_FRAME:AddMessage(Memento_MarkNormalFont("Memento: ") .. L["chat.notification.class"]:format(className))
        end

        if self.db.profile.options.notification.timePlayed then
            local seconds = Memento.totalTimePlayed
            local days = math.floor(seconds / 86400)
            seconds = seconds % 86400

            local hours = math.floor(seconds / 3600)
            seconds = seconds % 3600

            local minutes = math.floor(seconds / 60)
            seconds = seconds % 60

            DEFAULT_CHAT_FRAME:AddMessage(Memento_MarkNormalFont("Memento: ") .. L["chat.notification.timePlayed"]:format(days, hours, minutes, seconds))
        end
    end
end

function Memento:PrintDebug(msg)
    if self.db.profile.options.debug then
        local notfound = true

        for i = 1, NUM_CHAT_WINDOWS do
            local name, _, _, _, _, _, shown, locked, docked, uni = GetChatWindowInfo(i)

            if name == "Debug" and docked ~= nil then
                _G['ChatFrame' .. i]:AddMessage(Memento_MarkOrangeFont("Memento: ") .. msg)
                notfound = false
                break
            end
        end

        if notfound then
            DEFAULT_CHAT_FRAME:AddMessage(Memento_MarkOrangeFont("Memento (Debug): ") .. msg)
        end
	end
end



function Memento:PrintStatistic()
    if self.db.profile.options.notification then
        local msg = Memento_MarkNormalFont("Memento: ") .. L["statistic.screenshots.description"] .. "\n"

        if Memento.FLAVOR_IS_MAINLINE or Memento.FLAVOR_IS_CATA or Memento.FLAVOR_IS_MISTS then
            msg = msg .. Memento_MarkGoldFont(L["statistic.screenshots.achievement.personal"] .. ": ") .. self.dbStatstic.global.events.achievement.personal.count .. " (" .. self.dbStatstic.char.events.achievement.personal.count .. ")\n"
        end

        if Memento.FLAVOR_IS_MAINLINE then
            msg = msg .. Memento_MarkGoldFont(L["statistic.screenshots.achievement.criteria"] .. ": ") .. self.dbStatstic.global.events.achievement.criteria.count .. " (" .. self.dbStatstic.char.events.achievement.criteria.count .. ")\n"
        end

        if Memento.FLAVOR_IS_MAINLINE or Memento.FLAVOR_IS_CATA or Memento.FLAVOR_IS_MISTS then
            msg = msg .. Memento_MarkGoldFont(L["statistic.screenshots.achievement.guild"] .. ": ") .. self.dbStatstic.global.events.achievement.guild.count .. " (" .. self.dbStatstic.char.events.achievement.guild.count .. ")\n"
        end

        msg = msg .. Memento_MarkGoldFont(L["statistic.screenshots.encounter.victory"] .. ": ") .. self.dbStatstic.global.events.encounter.victory.count .. " (" .. self.dbStatstic.char.events.encounter.victory.count .. ")\n"
        msg = msg .. Memento_MarkGoldFont(L["statistic.screenshots.encounter.wipe"] .. ": ") .. self.dbStatstic.global.events.encounter.wipe.count .. " (" .. self.dbStatstic.char.events.encounter.wipe.count .. ")\n"
        msg = msg .. Memento_MarkGoldFont(L["statistic.screenshots.pvp.duel"] .. ": ") .. self.dbStatstic.global.events.pvp.duel.count .. " (" .. self.dbStatstic.char.events.pvp.duel.count .. ")\n"

        if Memento.FLAVOR_IS_MAINLINE then
            msg = msg .. Memento_MarkGoldFont(L["statistic.screenshots.pvp.arena"] .. ": ") .. self.dbStatstic.global.events.pvp.arena.count .. " (" .. self.dbStatstic.char.events.pvp.arena.count .. ")\n"
            msg = msg .. Memento_MarkGoldFont(L["statistic.screenshots.pvp.battleground"] .. ": ") .. self.dbStatstic.global.events.pvp.battleground.count .. " (" .. self.dbStatstic.char.events.pvp.battleground.count .. ")\n"
            msg = msg .. Memento_MarkGoldFont(L["statistic.screenshots.pvp.brawl"] .. ": ") .. self.dbStatstic.global.events.pvp.brawl.count .. " (" .. self.dbStatstic.char.events.pvp.brawl.count .. ")\n"
        end

        msg = msg .. Memento_MarkGoldFont(L["statistic.screenshots.levelUp"] .. ": ") .. self.dbStatstic.global.events.levelUp.count .. " (" .. self.dbStatstic.char.events.levelUp.count .. ")\n"
        msg = msg .. Memento_MarkGoldFont(L["statistic.screenshots.death"] .. ": ") .. self.dbStatstic.global.events.death.count .. " (" .. self.dbStatstic.char.events.death.count .. ")\n"
        msg = msg .. Memento_MarkGoldFont(L["statistic.screenshots.login"] .. ": ") .. self.dbStatstic.global.events.login.count .. " (" .. self.dbStatstic.char.events.login.count .. ")"
        DEFAULT_CHAT_FRAME:AddMessage(msg)
	end
end
