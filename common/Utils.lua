local addonName, MEM = ...

local L = MEM.Localization

local AWL = ArcaneWizardLibrary

local Utils = {}

-----------------------
--- Local Functions ---
-----------------------

local function CopyTable(source)
	local target = {}

	for key, value in pairs(source) do
		if type(value) == "table" then
			target[key] = CopyTable(value)
		else
			target[key] = value
		end
	end

	return target
end

local function GetCharacterRealmKey()
	return AWL.Utils:GetCharacterRealmKey()
end

------------------------
--- Public Functions ---
------------------------

function Utils:PrintDebug(msg)
	if MEM.settings.general["debug-mode"] then
		DEFAULT_CHAT_FRAME:AddMessage(ORANGE_FONT_COLOR:WrapTextInColorCode(addonName .. " (Debug): ") .. msg)
	end
end

function Utils:PrintMessage(msg)
	if MEM.settings.general["notification"] then
		if MEM.settings.general["notification-timestamp"] then
			local formattedTime = date("%d.%m.%y - %H:%M:%S")
			DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR:WrapTextInColorCode(addonName .. ": ") .. msg .. " [" .. formattedTime .. "]")
		else
			DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR:WrapTextInColorCode(addonName .. ": ") .. msg)
		end

		if MEM.settings.general["notification-class"] then
			local className = UnitClass("player")
			DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR:WrapTextInColorCode(addonName .. ": ") .. L["chat.notification.class"]:format(className))
		end

		if MEM.settings.general["notification-time-played"] then
			local seconds = MEM.state.totalTimePlayed
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

function Utils:IsAccountProfile()
	local characterRealmKey = GetCharacterRealmKey()

	return Memento_Options_v5.profileKeys[characterRealmKey]["use-account"]
end

function Utils:OpenSettingsOnLoading()
	local characterRealmKey = GetCharacterRealmKey()

	if Memento_Options_v5.profileKeys[characterRealmKey]["open-settings"] then
		Settings.OpenToCategory(MEM.MAIN_CATEGORY_ID)

		Memento_Options_v5.profileKeys[characterRealmKey]["open-settings"] = false
	end
end

function Utils:ToggleProfileMode()
	local characterRealmKey = GetCharacterRealmKey()
	local useAccountProfile = self:IsAccountProfile()

	Memento_Options_v5.profileKeys[characterRealmKey]["use-account"] = not useAccountProfile
	Memento_Options_v5.profileKeys[characterRealmKey]["open-settings"] = true
end

function Utils:ResetAllCharacterProfiles()
	local characterRealmKey = GetCharacterRealmKey()

	Memento_Options_v5.profiles = {}
	Memento_Options_v5.profileKeys = {}

	Memento_Options_v5.profileKeys[characterRealmKey] = {
		["use-account"] = true,
		["open-settings"] = true
	}
end

function Utils:InitializeDatabase()
	local characterRealmKey = GetCharacterRealmKey()

	local defaults = {
		["general"] = {
			["minimap-button"] = {
				["hide"] = false
			}
		},
		["event"] = {}
	}

	if not Memento_Options_v5 then
		Memento_Options_v5 = {
			["account"] = CopyTable(defaults),
			["profiles"] = {},
			["profileKeys"] = {}
		}
	end

	if not Memento_Options_v5.profiles[characterRealmKey] then
		Memento_Options_v5.profiles[characterRealmKey] = CopyTable(defaults)
	end

	if not Memento_Options_v5.profileKeys[characterRealmKey] then
		Memento_Options_v5.profileKeys[characterRealmKey] = {
			["use-account"] = true,
			["open-settings"] = false
		}
	end

	if Memento_Options_v5.profileKeys[characterRealmKey]["use-account"] then
		MEM.settings.general = Memento_Options_v5.account["general"]
		MEM.settings.event = Memento_Options_v5.account["event"]
	else
		MEM.settings.general = Memento_Options_v5.profiles[characterRealmKey]["general"]
		MEM.settings.event = Memento_Options_v5.profiles[characterRealmKey]["event"]
	end

	if not Memento_DataBossKill then
		Memento_DataBossKill = {}
	end

	if MEM.GAME_TYPE_MAINLINE then
		MEM.data.bossKill = Memento_DataBossKill
	end
end

function Utils:InitializeMinimapButton()
	local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("Memento", {
		type     = "launcher",
		text     = "Memento",
		icon     = MEM.MEDIA_PATH .. "icon-round.blp",
		OnClick  = function(self, button)
			if button == "RightButton" then
				if not InCombatLockdown() then
					Settings.OpenToCategory(MEM.MAIN_CATEGORY_ID)
				else
					Utils:PrintDebug("In combat. The options menu cannot be opened.")
				end
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
	self.minimapButton:Register("Memento", LDB, MEM.settings.general["minimap-button"])
end

MEM.modules.Utils = Utils
