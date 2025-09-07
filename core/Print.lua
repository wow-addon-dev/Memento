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
        DEFAULT_CHAT_FRAME:AddMessage(Memento_MarkOrangeFont("Memento (Debug): ") .. msg)
	end
end
