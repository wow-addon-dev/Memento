local addonName, MEM = ...

local L = MEM.Localization

local Utils = {}

---------------------
--- Main Funtions ---
---------------------

function Utils:PrintDebug(msg)
    if MEM.options.other["debug-mode"] then
		DEFAULT_CHAT_FRAME:AddMessage(ORANGE_FONT_COLOR:WrapTextInColorCode(addonName .. " (Debug): ")  .. msg)
	end
end

function Utils:PrintMessage(msg)
	if MEM.options.general["notification"] then
		if MEM.options.general["notification-timestamp"] then
			local formattedTime = date("%d.%m.%y - %H:%M:%S")
			DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR:WrapTextInColorCode(addonName .. ": ") .. msg .. " [" .. formattedTime .. "]")
		else
			DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR:WrapTextInColorCode(addonName .. ": ") .. msg)
		end

        if MEM.options.general["notification-class"] then
            local className = UnitClass("player")
            DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR:WrapTextInColorCode(addonName .. ": ") .. L["chat.notification.class"]:format(className))
        end

        if MEM.options.general["notification-time-played"] then
            local seconds = MEM.var.totalTimePlayed
            local days = math.floor(seconds / 86400)
            seconds = seconds % 86400

            local hours = math.floor(seconds / 3600)
            seconds = seconds % 3600

            local minutes = math.floor(seconds / 60)
            seconds = seconds % 60

            DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR:WrapTextInColorCode(addonName .. ": ") .. L["chat.notification.time-played"]:format(days, hours, minutes, seconds))
        end
	end
end

function Utils:InitializeDatabase()
    if (not Memento_Options_v4) then
        Memento_Options_v4 = {
			["general"] = {
				["minimap-button"] = {
					["hide"] = false
				}
			},
			["event"] = {},
			["other"] = {}
		}
    end

	if (not Memento_DataBossKill) then
        Memento_DataBossKill = {}
    end

    MEM.options = {}
	MEM.options.general = Memento_Options_v4["general"]
    MEM.options.event = Memento_Options_v4["event"]
	MEM.options.other = Memento_Options_v4["other"]

	if MEM.GAME_TYPE_MAINLINE then
		MEM.data = {}
		MEM.data.bossKill = Memento_DataBossKill
	end
end

function Utils:InitializeMinimapButton()
    local LDB = LibStub("LibDataBroker-1.1"):NewDataObject(addonName, {
        type     = "launcher",
        text     = addonName,
        icon     = MEM.MEDIA_PATH .. "icon-round.blp",
        OnClick  = function(self, button)
			if button == "RightButton" then
                Settings.OpenToCategory(MEM.MAIN_CATEGORY_ID)
            end
        end,
        OnTooltipShow = function(tooltip)
			GameTooltip_SetTitle(tooltip, addonName)
			GameTooltip_AddNormalLine(tooltip, MEM.ADDON_VERSION .. " (" .. MEM.ADDON_BUILD_DATE .. ")")
			GameTooltip_AddBlankLineToTooltip(tooltip)
			GameTooltip_AddHighlightLine(tooltip, L["minimap-button.tooltip"])
        end,
    })

    self.minimapButton = LibStub("LibDBIcon-1.0")
    self.minimapButton:Register(addonName, LDB, MEM.options.general["minimap-button"])
end

MEM.Utils = Utils
