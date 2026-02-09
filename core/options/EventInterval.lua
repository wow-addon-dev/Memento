local addonName, Memento = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local orderID = 2.19

Memento.optionsTable = Memento.optionsTable or {}

Memento.optionsTable["eventInterval"] = {
	name = L["options.event.interval"],
	type = "group",
	order = orderID,
	args = {
		LINE_1 = Memento_GetStyleLineSmall(0.11),
		active = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.interval"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.interval"]),
			get = function()
				return Memento.db.profile.events.interval.active
			end,
			set = function(_, value)
				Memento.db.profile.events.interval.active = value
			end,
			width = "full",
			order = 0.12
		},
		timer = {
			name = L["options.event.interval.timer.name"],
			desc = L["options.event.interval.timer.desc"],
			type = "range",
			min = 1,
			max = 60,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.interval.active
			end,
			get = function()
				return Memento.db.profile.events.interval.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.interval.timer = value
			end,
			order = 0.13
		},
		LINE_2 = Memento_GetStyleLineNormal(0.14),
	},
}
