local addonName, MEM = ...

local L = MEM.Localization
local Utils = MEM.Utils

local AWL = ArcaneWizardLibrary

local Options = {}

----------------------
--- Local Functions --
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

local function GetVal(setting) return setting:GetValue() end
local function FormatSeconds(value) return value .. " " .. L["general.seconds-short"] end
local function FormatMinutes(value) return value .. " " .. L["general.minutes-short"] end

---------------------
--- Main Functions --
---------------------

function Options:Initialize()
    local category, layout = Settings.RegisterVerticalLayoutCategory(addonName)

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.general"]))

    -- Notification
    local initializerNotification = AWL.Settings:AddCheckbox(category, {
        variableTable = MEM.options.general,
        settingKey    = addonName .. "_notification",
        variableName  = "notification",
        name          = L["options.general.notification.name"],
        tooltip       = L["options.general.notification.tooltip"],
        default       = true
    })

    local function IsNotificationEnabled()
        return MEM.options.general["notification"]
    end

    -- Notification: Show Timestamp
    AWL.Settings:AddCheckbox(category, {
        variableTable   = MEM.options.general,
        settingKey      = addonName .. "_notification-timestamp",
        variableName    = "notification-timestamp",
        name            = L["options.general.notification-timestamp.name"],
        tooltip         = L["options.general.notification-timestamp.tooltip"],
        default         = false,
        parentInit      = initializerNotification,
        parentCondition = IsNotificationEnabled
    })

    -- Notification: Show Class Colors
    AWL.Settings:AddCheckbox(category, {
        variableTable   = MEM.options.general,
        settingKey      = addonName .. "_notification-class",
        variableName    = "notification-class",
        name            = L["options.general.notification-class.name"],
        tooltip         = L["options.general.notification-class.tooltip"],
        default         = false,
        parentInit      = initializerNotification,
        parentCondition = IsNotificationEnabled
    })

    -- Notification: Show Time Played
    AWL.Settings:AddCheckbox(category, {
        variableTable   = MEM.options.general,
        settingKey      = addonName .. "_notification-time-played",
        variableName    = "notification-time-played",
        name            = L["options.general.notification-time-played.name"],
        tooltip         = L["options.general.notification-time-played.tooltip"],
        default         = false,
        parentInit      = initializerNotification,
        parentCondition = IsNotificationEnabled
    })

    -- Hide UI
    AWL.Settings:AddCheckbox(category, {
        variableTable = MEM.options.general,
        settingKey    = addonName .. "_hide-ui",
        variableName  = "hide-ui",
        name          = L["options.general.hide-ui.name"],
        tooltip       = L["options.general.hide-ui.tooltip"],
        default       = false
    })

    -- Minimap Button Visibility
    AWL.Settings:AddCheckbox(category, {
        variableTable = minimapButtonProxy,
        settingKey    = addonName .. "_hide",
        variableName  = "hide",
        name          = L["options.general.minimap-button.name"],
        tooltip       = L["options.general.minimap-button.tooltip"],
        default       = true
    })

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.event"]))

    if MEM.GAME_TYPE_MAINLINE or MEM.GAME_TYPE_MISTS then
        local _, isAchievementExpanded = AWL.Settings:CreateExpandableHeader(layout, L["options.event.achievement"])

        -- Personal Achievement
        local initializerAchievementPersonal, settingAchievementPersonal = AWL.Settings:AddCheckboxSliderCombo(category, layout, {
            variableTable      = MEM.options.event,
            checkboxSettingKey = addonName .. "_achievement-personal-active",
            checkboxVarName    = "achievement-personal-active",
            checkboxName       = L["options.event.achievement.personal"],
            checkboxTooltip    = L["options.event.general.active.tooltip"]:format(L["options.event.achievement.personal"]),
            checkboxDefault    = true,

            sliderSettingKey   = addonName .. "_achievement-personal-delay",
            sliderVariableName = "achievement-personal-delay",
            sliderName         = L["options.event.general.delay.name"],
            sliderTooltip      = L["options.event.general.delay.tooltip"]:format(L["options.event.achievement.personal"], 3),
            sliderDefault      = 3, sliderMin = 1, sliderMax = 10, sliderStep = 1,
            sliderFormatter    = FormatSeconds,

            shownPredicate     = isAchievementExpanded
        })

        -- Personal Achievement: Exist Check
        AWL.Settings:AddCheckbox(category, {
            variableTable   = MEM.options.event,
            settingKey      = addonName .. "_achievement-personal-exist",
            variableName    = "achievement-personal-exist",
            name            = L["options.event.achievement.personal.exist.name"],
            tooltip         = L["options.event.achievement.personal.exist.tooltip"],
            default         = false,
            parentInit      = initializerAchievementPersonal,
            parentCondition = function() return GetVal(settingAchievementPersonal) end,
            shownPredicate  = isAchievementExpanded
        })

        -- Criteria Achievement
        if MEM.GAME_TYPE_MAINLINE then
            AWL.Settings:AddCheckboxSliderCombo(category, layout, {
                variableTable      = MEM.options.event,
                checkboxSettingKey = addonName .. "_achievement-criteria-active",
                checkboxVarName    = "achievement-criteria-active",
                checkboxName       = L["options.event.achievement.criteria"],
                checkboxTooltip    = L["options.event.general.active.tooltip"]:format(L["options.event.achievement.criteria"]),
                checkboxDefault    = false,

                sliderSettingKey   = addonName .. "_achievement-criteria-delay",
                sliderVariableName = "achievement-criteria-delay",
                sliderName         = L["options.event.general.delay.name"],
                sliderTooltip      = L["options.event.general.delay.tooltip"]:format(L["options.event.achievement.criteria"], 3),
                sliderDefault      = 3, sliderMin = 1, sliderMax = 10, sliderStep = 1,
                sliderFormatter    = FormatSeconds,

                shownPredicate     = isAchievementExpanded
            })
        end

        -- Guild Achievement
        AWL.Settings:AddCheckboxSliderCombo(category, layout, {
            variableTable      = MEM.options.event,
            checkboxSettingKey = addonName .. "_achievement-guild-active",
            checkboxVarName    = "achievement-guild-active",
            checkboxName       = L["options.event.achievement.guild"],
            checkboxTooltip    = L["options.event.general.active.tooltip"]:format(L["options.event.achievement.guild"]),
            checkboxDefault    = true,

            sliderSettingKey   = addonName .. "_achievement-guild-delay",
            sliderVariableName = "achievement-guild-delay",
            sliderName         = L["options.event.general.delay.name"],
            sliderTooltip      = L["options.event.general.delay.tooltip"]:format(L["options.event.achievement.guild"], 3),
            sliderDefault      = 3, sliderMin = 1, sliderMax = 10, sliderStep = 1,
            sliderFormatter    = FormatSeconds,

            shownPredicate     = isAchievementExpanded
        })
    end

    local _, isEncounterExpanded = AWL.Settings:CreateExpandableHeader(layout, L["options.event.encounter"])
    local eventPartyVictory    = L["options.event.encounter.party"] .. " (" .. L["options.event.encounter.victory"] .. ")"
    local eventPartyWipe       = L["options.event.encounter.party"] .. " (" .. L["options.event.encounter.wipe"] .. ")"
    local eventRaidVictory     = L["options.event.encounter.raid"] .. " (" .. L["options.event.encounter.victory"] .. ")"
    local eventRaidWipe        = L["options.event.encounter.raid"] .. " (" .. L["options.event.encounter.wipe"] .. ")"
    local eventScenarioVictory = L["options.event.encounter.scenario"] .. " (" .. L["options.event.encounter.victory"] .. ")"
    local eventScenarioWipe    = L["options.event.encounter.scenario"] .. " (" .. L["options.event.encounter.wipe"] .. ")"

    -- Dungeon
    local initializerVictoryParty, settingVictoryParty = AWL.Settings:AddCheckboxSliderCombo(category, layout, {
        variableTable      = MEM.options.event,
        checkboxSettingKey = addonName .. "_encounter-victory-party-active",
        checkboxVarName    = "encounter-victory-party-active",
        checkboxName       = eventPartyVictory,
        checkboxTooltip    = L["options.event.general.active.tooltip"]:format(eventPartyVictory),
        checkboxDefault    = true,

        sliderSettingKey   = addonName .. "_encounter-victory-party-delay",
        sliderVariableName = "encounter-victory-party-delay",
        sliderName         = L["options.event.general.delay.name"],
        sliderTooltip      = L["options.event.general.delay.tooltip"]:format(eventPartyVictory, 2),
        sliderDefault      = 2, sliderMin = 1, sliderMax = 10, sliderStep = 1,
        sliderFormatter    = FormatSeconds,

        shownPredicate     = isEncounterExpanded
    })

    -- Dungeon: Only First Victory
    AWL.Settings:AddCheckbox(category, {
        variableTable   = MEM.options.event,
        settingKey      = addonName .. "_encounter-victory-party-first",
        variableName    = "encounter-victory-party-first",
        name            = L["options.event.encounter.victory.first.name"],
        tooltip         = L["options.event.encounter.victory.first.tooltip"],
        default         = false,
        parentInit      = initializerVictoryParty,
        parentCondition = function() return GetVal(settingVictoryParty) end,
        shownPredicate  = isEncounterExpanded
    })

    -- Dungeon: Wipe
    AWL.Settings:AddCheckboxSliderCombo(category, layout, {
        variableTable      = MEM.options.event,
        checkboxSettingKey = addonName .. "_encounter-wipe-party-active",
        checkboxVarName    = "encounter-wipe-party-active",
        checkboxName       = eventPartyWipe,
        checkboxTooltip    = L["options.event.general.active.tooltip"]:format(eventPartyWipe),
        checkboxDefault    = false,

        sliderSettingKey   = addonName .. "_encounter-wipe-party-delay",
        sliderVariableName = "encounter-wipe-party-delay",
        sliderName         = L["options.event.general.delay.name"],
        sliderTooltip      = L["options.event.general.delay.tooltip"]:format(eventPartyWipe, 2),
        sliderDefault      = 2, sliderMin = 1, sliderMax = 10, sliderStep = 1,
        sliderFormatter    = FormatSeconds,

        shownPredicate     = isEncounterExpanded
    })

    -- Raid
    local initializerVictoryRaid, settingVictoryRaid = AWL.Settings:AddCheckboxSliderCombo(category, layout, {
        variableTable      = MEM.options.event,
        checkboxSettingKey = addonName .. "_encounter-victory-raid-active",
        checkboxVarName    = "encounter-victory-raid-active",
        checkboxName       = eventRaidVictory,
        checkboxTooltip    = L["options.event.general.active.tooltip"]:format(eventRaidVictory),
        checkboxDefault    = true,

        sliderSettingKey   = addonName .. "_encounter-victory-raid-delay",
        sliderVariableName = "encounter-victory-raid-delay",
        sliderName         = L["options.event.general.delay.name"],
        sliderTooltip      = L["options.event.general.delay.tooltip"]:format(eventRaidVictory, 2),
        sliderDefault      = 2, sliderMin = 1, sliderMax = 10, sliderStep = 1,
        sliderFormatter    = FormatSeconds,

        shownPredicate     = isEncounterExpanded
    })

    -- Raid: Only First Victory
    AWL.Settings:AddCheckbox(category, {
        variableTable   = MEM.options.event,
        settingKey      = addonName .. "_encounter-victory-raid-first",
        variableName    = "encounter-victory-raid-first",
        name            = L["options.event.encounter.victory.first.name"],
        tooltip         = L["options.event.encounter.victory.first.tooltip"],
        default         = false,
        parentInit      = initializerVictoryRaid,
        parentCondition = function() return GetVal(settingVictoryRaid) end,
        shownPredicate  = isEncounterExpanded
    })

    -- Raid: Wipe
    AWL.Settings:AddCheckboxSliderCombo(category, layout, {
        variableTable      = MEM.options.event,
        checkboxSettingKey = addonName .. "_encounter-wipe-raid-active",
        checkboxVarName    = "encounter-wipe-raid-active",
        checkboxName       = eventRaidWipe,
        checkboxTooltip    = L["options.event.general.active.tooltip"]:format(eventRaidWipe),
        checkboxDefault    = false,

        sliderSettingKey   = addonName .. "_encounter-wipe-raid-delay",
        sliderVariableName = "encounter-wipe-raid-delay",
        sliderName         = L["options.event.general.delay.name"],
        sliderTooltip      = L["options.event.general.delay.tooltip"]:format(eventRaidWipe, 2),
        sliderDefault      = 2, sliderMin = 1, sliderMax = 10, sliderStep = 1,
        sliderFormatter    = FormatSeconds,

        shownPredicate     = isEncounterExpanded
    })

    -- Scenario
    if MEM.GAME_TYPE_MAINLINE then
        local initializerVictoryScenario, settingVictoryScenario = AWL.Settings:AddCheckboxSliderCombo(category, layout, {
            variableTable      = MEM.options.event,
            checkboxSettingKey = addonName .. "_encounter-victory-scenario-active",
            checkboxVarName    = "encounter-victory-scenario-active",
            checkboxName       = eventScenarioVictory,
            checkboxTooltip    = L["options.event.general.active.tooltip"]:format(eventScenarioVictory),
            checkboxDefault    = true,

            sliderSettingKey   = addonName .. "_encounter-victory-scenario-delay",
            sliderVariableName = "encounter-victory-scenario-delay",
            sliderName         = L["options.event.general.delay.name"],
            sliderTooltip      = L["options.event.general.delay.tooltip"]:format(eventScenarioVictory, 2),
            sliderDefault      = 2, sliderMin = 1, sliderMax = 10, sliderStep = 1,
            sliderFormatter    = FormatSeconds,

            shownPredicate     = isEncounterExpanded
        })

        -- Scenario: Only First Victory
        AWL.Settings:AddCheckbox(category, {
            variableTable   = MEM.options.event,
            settingKey      = addonName .. "_encounter-victory-scenario-first",
            variableName    = "encounter-victory-scenario-first",
            name            = L["options.event.encounter.victory.first.name"],
            tooltip         = L["options.event.encounter.victory.first.tooltip"],
            default         = false,
            parentInit      = initializerVictoryScenario,
            parentCondition = function() return GetVal(settingVictoryScenario) end,
            shownPredicate  = isEncounterExpanded
        })

        -- Scenario: Wipe
        AWL.Settings:AddCheckboxSliderCombo(category, layout, {
            variableTable      = MEM.options.event,
            checkboxSettingKey = addonName .. "_encounter-wipe-scenario-active",
            checkboxVarName    = "encounter-wipe-scenario-active",
            checkboxName       = eventScenarioWipe,
            checkboxTooltip    = L["options.event.general.active.tooltip"]:format(eventScenarioWipe),
            checkboxDefault    = false,

            sliderSettingKey   = addonName .. "_encounter-wipe-scenario-delay",
            sliderVariableName = "encounter-wipe-scenario-delay",
            sliderName         = L["options.event.general.delay.name"],
            sliderTooltip      = L["options.event.general.delay.tooltip"]:format(eventScenarioWipe, 2),
            sliderDefault      = 2, sliderMin = 1, sliderMax = 10, sliderStep = 1,
            sliderFormatter    = FormatSeconds,

            shownPredicate     = isEncounterExpanded
        })
    end

    local _, isPvPExpanded = AWL.Settings:CreateExpandableHeader(layout, L["options.event.pvp"])

    -- Duel (Global)
    AWL.Settings:AddCheckboxSliderCombo(category, layout, {
        variableTable      = MEM.options.event,
        checkboxSettingKey = addonName .. "_pvp-duel-active",
        checkboxVarName    = "pvp-duel-active",
        checkboxName       = L["options.event.pvp.duel"],
        checkboxTooltip    = L["options.event.general.active.tooltip"]:format(L["options.event.pvp.duel"]),
        checkboxDefault    = true,

        sliderSettingKey   = addonName .. "_pvp-duel-delay",
        sliderVariableName = "pvp-duel-delay",
        sliderName         = L["options.event.general.delay.name"],
        sliderDefault      = 1, sliderMin = 1, sliderMax = 10, sliderStep = 1,
        sliderFormatter    = FormatSeconds,

        shownPredicate     = isPvPExpanded
    })

    if MEM.GAME_TYPE_MAINLINE then
        -- Arena
        AWL.Settings:AddCheckboxSliderCombo(category, layout, {
            variableTable      = MEM.options.event,
            checkboxSettingKey = addonName .. "_pvp-arena-active",
            checkboxVarName    = "pvp-arena-active",
            checkboxName       = L["options.event.pvp.arena"],
            checkboxTooltip    = L["options.event.general.active.tooltip"]:format(L["options.event.pvp.arena"]),
            checkboxDefault    = true,

            sliderSettingKey   = addonName .. "_pvp-arena-delay",
            sliderVariableName = "pvp-arena-delay",
            sliderName         = L["options.event.general.delay.name"],
            sliderDefault      = 3, sliderMin = 1, sliderMax = 10, sliderStep = 1,
            sliderFormatter    = FormatSeconds,

            shownPredicate     = isPvPExpanded
        })

        -- Battleground
        local initializerBattleground, settingBattleground = AWL.Settings:AddCheckboxSliderCombo(category, layout, {
            variableTable      = MEM.options.event,
            checkboxSettingKey = addonName .. "_pvp-battleground-active",
            checkboxVarName    = "pvp-battleground-active",
            checkboxName       = L["options.event.pvp.battleground"],
            checkboxTooltip    = L["options.event.general.active.tooltip"]:format(L["options.event.pvp.battleground"]),
            checkboxDefault    = true,

            sliderSettingKey   = addonName .. "_pvp-battleground-delay",
            sliderVariableName = "pvp-battleground-delay",
            sliderName         = L["options.event.general.delay.name"],
            sliderDefault      = 3, sliderMin = 1, sliderMax = 10, sliderStep = 1,
            sliderFormatter    = FormatSeconds,

            shownPredicate     = isPvPExpanded
        })

        -- Battleground: Only Victory
        AWL.Settings:AddCheckbox(category, {
            variableTable   = MEM.options.event,
            settingKey      = addonName .. "_pvp-battleground-victory-only",
            variableName    = "pvp-battleground-victory-only",
            name            = L["options.event.pvp.victory.name"],
            tooltip         = L["options.event.pvp.victory.tooltip"],
            default         = false,
            parentInit      = initializerBattleground,
            parentCondition = function() return GetVal(settingBattleground) end,
            shownPredicate  = isPvPExpanded
        })

        -- Brawl
        local initializerBrawl, settingBrawl = AWL.Settings:AddCheckboxSliderCombo(category, layout, {
            variableTable      = MEM.options.event,
            checkboxSettingKey = addonName .. "_pvp-brawl-active",
            checkboxVarName    = "pvp-brawl-active",
            checkboxName       = L["options.event.pvp.brawl"],
            checkboxTooltip    = L["options.event.general.active.tooltip"]:format(L["options.event.pvp.brawl"]),
            checkboxDefault    = true,

            sliderSettingKey   = addonName .. "_pvp-brawl-delay",
            sliderVariableName = "pvp-brawl-delay",
            sliderName         = L["options.event.general.delay.name"],
            sliderDefault      = 3, sliderMin = 1, sliderMax = 10, sliderStep = 1,
            sliderFormatter    = FormatSeconds,

            shownPredicate     = isPvPExpanded
        })

        -- Brawl: Only Victory
        AWL.Settings:AddCheckbox(category, {
            variableTable   = MEM.options.event,
            settingKey      = addonName .. "_pvp-brawl-victory-only",
            variableName    = "pvp-brawl-victory-only",
            name            = L["options.event.pvp.victory.name"],
            tooltip         = L["options.event.pvp.victory.tooltip"],
            default         = false,
            parentInit      = initializerBrawl,
            parentCondition = function() return GetVal(settingBrawl) end,
            shownPredicate  = isPvPExpanded
        })
    end

    local _, isWarbandCollectionExpanded = AWL.Settings:CreateExpandableHeader(layout, L["options.event.warband-collection"])

    local function AddWarbandEntry(key, nameString, condition)
        if condition then
            AWL.Settings:AddCheckboxSliderCombo(category, layout, {
                variableTable      = MEM.options.event,
                checkboxSettingKey = addonName .. "_collection-" .. key .. "-active",
                checkboxVarName    = "collection-" .. key .. "-active",
                checkboxName       = nameString,
                checkboxTooltip    = L["options.event.general.active.tooltip"]:format(nameString),
                checkboxDefault    = false,

                sliderSettingKey   = addonName .. "_collection-" .. key .. "-delay",
                sliderVariableName = "collection-" .. key .. "-delay",
                sliderName         = L["options.event.general.delay.name"],
                sliderTooltip      = L["options.event.general.delay.tooltip"]:format(nameString, 1),
                sliderDefault      = 1, sliderMin = 1, sliderMax = 10, sliderStep = 1,
                sliderFormatter    = FormatSeconds,

                shownPredicate     = isWarbandCollectionExpanded
            })
        end
    end

    AddWarbandEntry("pet", L["options.event.warband-collection.new-pet"], MEM.GAME_TYPE_MAINLINE or MEM.GAME_TYPE_MISTS)
    AddWarbandEntry("mount", L["options.event.warband-collection.new-mount"], MEM.GAME_TYPE_MAINLINE or MEM.GAME_TYPE_MISTS)
    AddWarbandEntry("toy", L["options.event.warband-collection.new-toy"], MEM.GAME_TYPE_MAINLINE or MEM.GAME_TYPE_MISTS)
    AddWarbandEntry("recipe", L["options.event.warband-collection.new-recipe"], true)
    AddWarbandEntry("housing", L["options.event.warband-collection.new-housing-item"], MEM.GAME_TYPE_MAINLINE)

    local _, isOtherExpanded = AWL.Settings:CreateExpandableHeader(layout, L["options.event.other"])

    -- Login
    AWL.Settings:AddCheckboxSliderCombo(category, layout, {
        variableTable      = MEM.options.event,
        checkboxSettingKey = addonName .. "_login-active",
        checkboxVarName    = "login-active",
        checkboxName       = L["options.event.other.login"],
        checkboxTooltip    = L["options.event.general.active.tooltip"]:format(L["options.event.other.login"]),
        checkboxDefault    = false,

        sliderSettingKey   = addonName .. "_login-delay",
        sliderVariableName = "login-delay",
        sliderName         = L["options.event.general.delay.name"],
        sliderTooltip      = L["options.event.general.delay.tooltip"]:format(L["options.event.other.login"], 5),
        sliderDefault      = 5, sliderMin = 1, sliderMax = 10, sliderStep = 1,
        sliderFormatter    = FormatSeconds,

        shownPredicate     = isOtherExpanded
    })

    -- Level-Up
    AWL.Settings:AddCheckboxSliderCombo(category, layout, {
        variableTable      = MEM.options.event,
        checkboxSettingKey = addonName .. "_level-up-active",
        checkboxVarName    = "level-up-active",
        checkboxName       = L["options.event.other.level-up"],
        checkboxTooltip    = L["options.event.general.active.tooltip"]:format(L["options.event.other.level-up"]),
        checkboxDefault    = true,

        sliderSettingKey   = addonName .. "_level-up-delay",
        sliderVariableName = "level-up-delay",
        sliderName         = L["options.event.general.delay.name"],
        sliderTooltip      = L["options.event.general.delay.tooltip"]:format(L["options.event.other.level-up"], 5),
        sliderDefault      = 5, sliderMin = 1, sliderMax = 10, sliderStep = 1,
        sliderFormatter    = FormatSeconds,

        shownPredicate     = isOtherExpanded
    })

    -- Death
    local initializerDeath, settingDeath = AWL.Settings:AddCheckboxSliderCombo(category, layout, {
        variableTable      = MEM.options.event,
        checkboxSettingKey = addonName .. "_death-active",
        checkboxVarName    = "death-active",
        checkboxName       = L["options.event.other.death"],
        checkboxTooltip    = L["options.event.general.active.tooltip"]:format(L["options.event.other.death"]),
        checkboxDefault    = true,

        sliderSettingKey   = addonName .. "_death-delay",
        sliderVariableName = "death-delay",
        sliderName         = L["options.event.general.delay.name"],
        sliderTooltip      = L["options.event.general.delay.tooltip"]:format(L["options.event.other.death"], 1),
        sliderDefault      = 1, sliderMin = 1, sliderMax = 10, sliderStep = 1,
        sliderFormatter    = FormatSeconds,

        shownPredicate     = isOtherExpanded
    })

    -- Death: Instance
    AWL.Settings:AddDropdown(category, {
        variableTable   = MEM.options.event,
        settingKey      = addonName .. "_death-instance",
        variableName    = "death-instance",
        name            = L["options.event.other.death.instance.name"],
        tooltip         = L["options.event.other.death.instance.tooltip"],
        default         = 0,
        options         = {
            {value = 0, label = L["options.event.other.death.instance.option.0"]},
            {value = 1, label = L["options.event.other.death.instance.option.1"]},
            {value = 2, label = L["options.event.other.death.instance.option.2"]}
        },
        parentInit      = initializerDeath,
        parentCondition = function() return GetVal(settingDeath) end,
        shownPredicate  = isOtherExpanded
    })

    -- Mythic+
    if MEM.GAME_TYPE_MAINLINE then
        AWL.Settings:AddCheckboxSliderCombo(category, layout, {
            variableTable      = MEM.options.event,
            checkboxSettingKey = addonName .. "_mythic-active",
            checkboxVarName    = "mythic-active",
            checkboxName       = L["options.event.other.mythic"],
            checkboxTooltip    = L["options.event.general.active.tooltip"]:format(L["options.event.other.mythic"]),
            checkboxDefault    = false,

            sliderSettingKey   = addonName .. "_mythic-delay",
            sliderVariableName = "mythic-delay",
            sliderName         = L["options.event.general.delay.name"],
            sliderTooltip      = L["options.event.general.delay.tooltip"]:format(L["options.event.other.mythic"], 1),
            sliderDefault      = 1, sliderMin = 1, sliderMax = 10, sliderStep = 1,
            sliderFormatter    = FormatSeconds,

            shownPredicate     = isOtherExpanded
        })
    end

    -- Interval
    AWL.Settings:AddCheckboxSliderCombo(category, layout, {
        variableTable      = MEM.options.event,
        checkboxSettingKey = addonName .. "_interval-active",
        checkboxVarName    = "interval-active",
        checkboxName       = L["options.event.other.interval"],
        checkboxTooltip    = L["options.event.general.active.tooltip"]:format(L["options.event.other.interval"]),
        checkboxDefault    = false,

        sliderSettingKey   = addonName .. "_interval-timer",
        sliderVariableName = "interval-timer",
        sliderName         = L["options.event.other.interval-timer.name"],
        sliderTooltip      = L["options.event.other.interval-timer.tooltip"],
        sliderDefault      = 5, sliderMin = 1, sliderMax = 60, sliderStep = 1,
        sliderFormatter    = FormatMinutes,

        shownPredicate     = isOtherExpanded
    })

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.other"]))

    -- Debug Mode
    AWL.Settings:AddCheckbox(category, {
        variableTable = MEM.options.other,
        settingKey    = addonName .. "_debug-mode",
        variableName  = "debug-mode",
        name          = L["options.other.debug-mode.name"],
        tooltip       = L["options.other.debug-mode.tooltip"],
        default       = false
    })

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.about"]))

    -- Game Version
    AWL.Settings:AddInfoText(layout, {
        leftText  = L["options.about.game-version"],
        rightText = MEM.GAME_VERSION .. " (" .. MEM.GAME_FLAVOR .. ")"
    })

    -- Addon Version
    AWL.Settings:AddInfoText(layout, {
        leftText  = L["options.about.addon-version"],
        rightText = MEM.ADDON_VERSION .. " (" .. MEM.ADDON_BUILD_DATE .. ")"
    })

    -- Library Version
    AWL.Settings:AddInfoText(layout, {
        leftText  = L["options.about.lib-version"],
        rightText = AWL.ADDON_VERSION .. " (" .. AWL.ADDON_BUILD_DATE .. ")"
    })

    -- Author
    AWL.Settings:AddInfoText(layout, {
        leftText  = L["options.about.author"],
        rightText = MEM.ADDON_AUTHOR,
        height    = 30
    })

    -- GitHub Link
    AWL.Settings:AddButton(layout, {
        name       = L["options.about.button-github.name"],
        buttonText = L["options.about.button-github.button"],
        tooltip    = L["options.about.button-github.tooltip"],
        onClick    = function()
            AWL.Dialogs:ShowLinkDialog(MEM.LINK_GITHUB)
        end
    })

    Settings.RegisterAddOnCategory(category)

    MEM.MAIN_CATEGORY_ID = category:GetID()
end

MEM.Options = Options
