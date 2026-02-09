local addonName, Memento = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local orderID = 2.16

Memento.optionsTable = Memento.optionsTable or {}

Memento.optionsTable["eventDeath"] = {
	name = L["options.event.death"],
	type = "group",
	order = orderID,
	args = {
		LINE_1 = Memento_GetStyleLineSmall(0.11),
		active = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.death"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.death"]),
			get = function()
				return Memento.db.profile.events.death.active
			end,
			set = function(_, value)
				Memento.db.profile.events.death.active = value
			end,
			width = "full",
			order = 0.12
		},
		instance = {
			type = "select",
			name = L["options.event.death.instance.name"],
			desc = L["options.event.death.instance.desc"],
			values = {
				[0] = L["options.event.death.instance.option.0"],
				[1] = L["options.event.death.instance.option.1"],
				[2] = L["options.event.death.instance.option.2"]
			},
			disabled = function()
				return not Memento.db.profile.events.death.active
			end,
			get = function()
				return Memento.db.profile.events.death.instance
			end,
			set = function(_, value)
				Memento.db.profile.events.death.instance = value
			end,
			width = 1.5,
			order = 0.13
		},
		timer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.death"], 1),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.death.active
			end,
			get = function()
				return Memento.db.profile.events.death.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.death.timer = value
			end,
			order = 0.14
		},
		LINE_2 = Memento_GetStyleLineNormal(0.14),
	},
}
