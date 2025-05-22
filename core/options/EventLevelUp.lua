local addonName, Memento = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local orderID = 2.5

Memento.optionsTable = Memento.optionsTable or {}

Memento.optionsTable["eventLevelUp"] = {
	name = L["options.event.levelUp"],
	type = "group",
	order = orderID,
	args = {
		LINE_1 = Memento_GetStyleLineSmall(0.11),
		active = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.levelUp"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.levelUp"]),
			get = function()
				return Memento.db.profile.events.levelUp.active
			end,
			set = function(_, value)
				Memento.db.profile.events.levelUp.active = value
			end,
			width = "full",
			order = 0.12
		},
		timer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.levelUp"], 5),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.levelUp.active
			end,
			get = function()
				return Memento.db.profile.events.levelUp.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.levelUp.timer = value
			end,
			order = 0.13
		},
		LINE_2 = Memento_GetStyleLineNormal(0.14),
	},
}
