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
	local variableTableEvent = MEM.options.event
	local variableTableOther = MEM.options.other

	local parentCheckboxNotification
	local parentCheckboxAchievementPersonal

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.general"]))

    do
        local name = L["options.general.notification.name"]
        local tooltip = L["options.general.notification.tooltip"]
        local variable = "notification"
        local defaultValue = true

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableGeneral, Settings.VarType.Boolean, name, defaultValue)
        parentCheckboxNotification = Settings.CreateCheckbox(category, setting, tooltip)
    end

	do
        local name = L["options.general.notification-timestamp.name"]
        local tooltip = L["options.general.notification-timestamp.tooltip"]
        local variable = "notification-timestamp"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableGeneral, Settings.VarType.Boolean, name, defaultValue)
        local checkbox = Settings.CreateCheckbox(category, setting, tooltip)
		checkbox:SetParentInitializer(parentCheckboxNotification, function() return MEM.options.general["notification"] end)
    end

	do
        local name = L["options.general.notification-class.name"]
        local tooltip = L["options.general.notification-class.tooltip"]
        local variable = "notification-class"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableGeneral, Settings.VarType.Boolean, name, defaultValue)
        local checkbox = Settings.CreateCheckbox(category, setting, tooltip)
		checkbox:SetParentInitializer(parentCheckboxNotification, function() return MEM.options.general["notification"] end)
    end

	do
        local name = L["options.general.notification-time-played.name"]
        local tooltip = L["options.general.notification-time-played.tooltip"]
        local variable = "notification-time-played"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableGeneral, Settings.VarType.Boolean, name, defaultValue)
        local checkbox = Settings.CreateCheckbox(category, setting, tooltip)
		checkbox:SetParentInitializer(parentCheckboxNotification, function() return MEM.options.general["notification"] end)
    end

	do
        local name = L["options.general.hide-ui.name"]
        local tooltip = L["options.general.hide-ui.tooltip"]
        local variable = "hide-ui"
        local defaultValue = false

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

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.event.achievement"]))
local ds
	do
		local nameCheckbox = L["options.event.achievement.personal"]
        local tooltipCheckbox = L["options.event.general.active.tooltip"]:format(L["options.event.achievement.personal"])
        local variableCheckbox = "achievement-personal-active"
        local defaultValueCheckbox = true

        ds = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableCheckbox, variableCheckbox, variableTableEvent, Settings.VarType.Boolean, nameCheckbox, defaultValueCheckbox)

        local nameSlider = L["options.event.general.delay.name"]
        local tooltipSlider = L["options.event.general.delay.tooltip"]:format(L["options.event.achievement.personal"], 3)
        local variableSlider = "achievement-personal-delay"
        local defaultValueSlider = 3

        local minValue = 1
        local maxValue = 10
        local step = 1

        local settingSlider = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableSlider, variableSlider, variableTableEvent, Settings.VarType.Number, nameSlider, defaultValueSlider)

		local optionsSlider = Settings.CreateSliderOptions(minValue, maxValue, step)
        optionsSlider:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value) return value .. " " .. L["general.seconds-short"] end)

        parentCheckboxAchievementPersonal = CreateSettingsCheckboxSliderInitializer(ds, nameCheckbox, tooltipCheckbox, settingSlider, optionsSlider, nameSlider, tooltipSlider)

        layout:AddInitializer(parentCheckboxAchievementPersonal)
	end

	do
        local name = L["options.event.achievement.personal.exist.name"]
        local tooltip = L["options.event.achievement.personal.exist.tooltip"]
        local variable = "achievement-personal-exist"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableEvent, Settings.VarType.Boolean, name, defaultValue)
        local checkbox = Settings.CreateCheckbox(category, setting, tooltip)

        parentCheckboxAchievementPersonal.GetSetting = function(self) return ds end
        checkbox:SetParentInitializer(parentCheckboxAchievementPersonal, function() return ds:GetValue() end)
    end

	do
		local nameCheckbox = L["options.event.achievement.criteria"]
        local tooltipCheckbox = L["options.event.general.active.tooltip"]:format(L["options.event.achievement.criteria"])
        local variableCheckbox = "achievement-criteria-active"
        local defaultValueCheckbox = false

        local settingCheckbox = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableCheckbox, variableCheckbox, variableTableEvent, Settings.VarType.Boolean, nameCheckbox, defaultValueCheckbox)

        local nameSlider = L["options.event.general.delay.name"]
        local tooltipSlider = L["options.event.general.delay.tooltip"]:format(L["options.event.achievement.criteria"], 3)
        local variableSlider = "achievement-criteria-delay"
        local defaultValueSlider = 3

        local minValue = 1
        local maxValue = 10
        local step = 1

        local settingSlider = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableSlider, variableSlider, variableTableEvent, Settings.VarType.Number, nameSlider, defaultValueSlider)

		local optionsSlider = Settings.CreateSliderOptions(minValue, maxValue, step)
        optionsSlider:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value) return value .. " " .. L["general.seconds-short"] end)

        local initializer = CreateSettingsCheckboxSliderInitializer(settingCheckbox, nameCheckbox, tooltipCheckbox, settingSlider, optionsSlider, nameSlider, tooltipSlider)

        layout:AddInitializer(initializer)
	end

	do
		local nameCheckbox = L["options.event.achievement.guild"]
        local tooltipCheckbox = L["options.event.general.active.tooltip"]:format(L["options.event.achievement.guild"])
        local variableCheckbox = "achievement-guild-active"
        local defaultValueCheckbox = false

        local settingCheckbox = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableCheckbox, variableCheckbox, variableTableEvent, Settings.VarType.Boolean, nameCheckbox, defaultValueCheckbox)

        local nameSlider = L["options.event.general.delay.name"]
        local tooltipSlider = L["options.event.general.delay.tooltip"]:format(L["options.event.achievement.guild"], 3)
        local variableSlider = "achievement-guild-delay"
        local defaultValueSlider = 3

        local minValue = 1
        local maxValue = 10
        local step = 1

        local settingSlider = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableSlider, variableSlider, variableTableEvent, Settings.VarType.Number, nameSlider, defaultValueSlider)

		local optionsSlider = Settings.CreateSliderOptions(minValue, maxValue, step)
        optionsSlider:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value) return value .. " " .. L["general.seconds-short"] end)

        local initializer = CreateSettingsCheckboxSliderInitializer(settingCheckbox, nameCheckbox, tooltipCheckbox, settingSlider, optionsSlider, nameSlider, tooltipSlider)

        layout:AddInitializer(initializer)
	end

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.event.other"]))

	do
		local nameCheckbox = L["options.event.other.login"]
        local tooltipCheckbox = L["options.event.general.active.tooltip"]:format(L["options.event.other.login"])
        local variableCheckbox = "login-active"
        local defaultValueCheckbox = true

        local settingCheckbox = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableCheckbox, variableCheckbox, variableTableEvent, Settings.VarType.Boolean, nameCheckbox, defaultValueCheckbox)

        local nameSlider = L["options.event.general.delay.name"]
        local tooltipSlider = L["options.event.general.delay.tooltip"]:format(L["options.event.other.login"], 3)
        local variableSlider = "login-delay"
        local defaultValueSlider = 3

        local minValue = 1
        local maxValue = 10
        local step = 1

        local settingSlider = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableSlider, variableSlider, variableTableEvent, Settings.VarType.Number, nameSlider, defaultValueSlider)

		local optionsSlider = Settings.CreateSliderOptions(minValue, maxValue, step)
        optionsSlider:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value) return value .. " " .. L["general.seconds-short"] end)

        local initializer = CreateSettingsCheckboxSliderInitializer(settingCheckbox, nameCheckbox, tooltipCheckbox, settingSlider, optionsSlider, nameSlider, tooltipSlider)

        layout:AddInitializer(initializer)
	end

	do
		local nameCheckbox = L["options.event.other.level-up"]
        local tooltipCheckbox = L["options.event.general.active.tooltip"]:format(L["options.event.other.level-up"])
        local variableCheckbox = "level-up-active"
        local defaultValueCheckbox = true

        local settingCheckbox = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableCheckbox, variableCheckbox, variableTableEvent, Settings.VarType.Boolean, nameCheckbox, defaultValueCheckbox)

        local nameSlider = L["options.event.general.delay.name"]
        local tooltipSlider = L["options.event.general.delay.tooltip"]:format(L["options.event.other.level-up"], 3)
        local variableSlider = "level-up-delay"
        local defaultValueSlider = 3

        local minValue = 1
        local maxValue = 10
        local step = 1

        local settingSlider = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableSlider, variableSlider, variableTableEvent, Settings.VarType.Number, nameSlider, defaultValueSlider)

		local optionsSlider = Settings.CreateSliderOptions(minValue, maxValue, step)
        optionsSlider:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value) return value .. " " .. L["general.seconds-short"] end)

        local initializer = CreateSettingsCheckboxSliderInitializer(settingCheckbox, nameCheckbox, tooltipCheckbox, settingSlider, optionsSlider, nameSlider, tooltipSlider)

        layout:AddInitializer(initializer)
	end

	do
		local nameCheckbox = L["options.event.other.mythic"]
        local tooltipCheckbox = L["options.event.general.active.tooltip"]:format(L["options.event.other.mythic"])
        local variableCheckbox = "mythic-active"
        local defaultValueCheckbox = false

        local settingCheckbox = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableCheckbox, variableCheckbox, variableTableEvent, Settings.VarType.Boolean, nameCheckbox, defaultValueCheckbox)

        local nameSlider = L["options.event.general.delay.name"]
        local tooltipSlider = L["options.event.general.delay.tooltip"]:format(L["options.event.other.mythic"], 3)
        local variableSlider = "mythic-delay"
        local defaultValueSlider = 3

        local minValue = 1
        local maxValue = 10
        local step = 1

        local settingSlider = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableSlider, variableSlider, variableTableEvent, Settings.VarType.Number, nameSlider, defaultValueSlider)

		local optionsSlider = Settings.CreateSliderOptions(minValue, maxValue, step)
        optionsSlider:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value) return value .. " " .. L["general.seconds-short"] end)

        local initializer = CreateSettingsCheckboxSliderInitializer(settingCheckbox, nameCheckbox, tooltipCheckbox, settingSlider, optionsSlider, nameSlider, tooltipSlider)

        layout:AddInitializer(initializer)
	end

	do
		local nameCheckbox = L["options.event.other.interval"]
        local tooltipCheckbox = L["options.event.general.active.tooltip"]:format(L["options.event.other.interval"])
        local variableCheckbox = "interval-active"
        local defaultValueCheckbox = false

        local settingCheckbox = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableCheckbox, variableCheckbox, variableTableEvent, Settings.VarType.Boolean, nameCheckbox, defaultValueCheckbox)

        local nameSlider = L["options.event.other.interval-timer.name"]
        local tooltipSlider = L["options.event.other.interval-timer.tooltip"]
        local variableSlider = "interval-timer"
        local defaultValueSlider = 5

        local minValue = 1
        local maxValue = 60
        local step = 1

        local settingSlider = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableSlider, variableSlider, variableTableEvent, Settings.VarType.Number, nameSlider, defaultValueSlider)

		local optionsSlider = Settings.CreateSliderOptions(minValue, maxValue, step)
        optionsSlider:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value) return value .. " " .. L["general.minutes-short"] end)

        local initializer = CreateSettingsCheckboxSliderInitializer(settingCheckbox, nameCheckbox, tooltipCheckbox, settingSlider, optionsSlider, nameSlider, tooltipSlider)

        layout:AddInitializer(initializer)
	end

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
