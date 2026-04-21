local addonName, MEM = ...

local L = MEM.Localization
local Utils = MEM.Utils

local AWL = ArcaneWizardLibrary

local Options = {}

----------------------
--- Local Funtions ---
----------------------

local minimapButtonProxy = setmetatable({}, {
    __index = function(_, key)
        return not MEM.options.general["minimap-button"]["hide"]
    end,
    __newindex = function(_, key, value)
        MEM.options.general["minimap-button"]["hide"] = not value

        if value then
            Utils.minimapButton:Show(addonName)
        else
            Utils.minimapButton:Hide(addonName)
        end
    end,
})

---------------------
--- Main Funtions ---
---------------------

function Options:Initialize()
    local category, layout = Settings.RegisterVerticalLayoutCategory(addonName)

	local variableTableGeneral = MEM.options.general
	local variableTableCombatTimeTracker = MEM.options.combatTimeTracker
	local variableTableOther = MEM.options.other

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.general"]))

    do
        local name = L["options.general.notification.name"]
        local tooltip = L["options.general.notification.tooltip"]
        local variable = "notification"
        local defaultValue = true

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableGeneral, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

	do
        local name = L["options.general.minimap-button.name"]
        local tooltip = L["options.general.minimap-button.tooltip"]
        local variable = "hide"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, minimapButtonProxy, Settings.VarType.Boolean, name, not defaultValue)

        Settings.CreateCheckbox(category, setting, tooltip)
    end

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.screenshots"]))


    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.other"]))

    do
        local name = L["options.other.debug-mode.name"]
        local tooltip = L["options.other.debug-mode.tooltip"]
        local variable = "debug-mode"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableOther, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.about"]))

	do
		layout:AddInitializer(Settings.CreateElementInitializer("ArcaneWizardLibrary_SettingsPanelTextNormal", {
			leftText = L["options.about.game-version"],
			rightText = MEM.GAME_VERSION .. " (" .. MEM.GAME_FLAVOR .. ")",
		}))
	end

	do
		layout:AddInitializer(Settings.CreateElementInitializer("ArcaneWizardLibrary_SettingsPanelTextNormal", {
			leftText = L["options.about.addon-version"],
			rightText = MEM.ADDON_VERSION .. " (" .. MEM.ADDON_BUILD_DATE .. ")"
		}))
	end

	do
		layout:AddInitializer(Settings.CreateElementInitializer("ArcaneWizardLibrary_SettingsPanelTextNormal", {
			leftText = L["options.about.lib-version"],
			rightText = AWL.ADDON_VERSION .. " (" .. AWL.ADDON_BUILD_DATE .. ")"
		}))
	end

	do
		layout:AddInitializer(Settings.CreateElementInitializer("ArcaneWizardLibrary_SettingsPanelTextLarge", {
			leftText = L["options.about.author"],
			rightText = MEM.ADDON_AUTHOR
		}))
	end

	do
        local name = L["options.about.button-github.name"]
        local tooltip = L["options.about.button-github.tooltip"]
		local buttonText = L["options.about.button-github.button"]

        local function OnButtonClick()
            AWL.Dialogs:ShowLinkDialog(MEM.LINK_GITHUB)
        end

        local buttonInitializer = CreateSettingsButtonInitializer(name, buttonText, OnButtonClick, tooltip, true)
        layout:AddInitializer(buttonInitializer)
    end

    Settings.RegisterAddOnCategory(category)

	MEM.MAIN_CATEGORY_ID = category:GetID()
end

MEM.Options = Options
