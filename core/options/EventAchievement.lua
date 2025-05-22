local addonName, Memento = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local orderID = 2.2

Memento.optionsTable = Memento.optionsTable or {}

Memento.optionsTable["eventAchievement-mainline"] = {
	name = L["options.event.achievement"],
	type = "group",
	order = orderID,
	args = {
		LINE_1 = Memento_GetStyleLineSmall(0.11),
		SEPARATOR_1  = Memento_GetStyleSeparatorText(0.12, " " .. L["options.event.achievement.personal"]),
		personalActive = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.achievement.personal"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.achievement.personal"]),
			get = function()
				return Memento.db.profile.events.achievement.personal.active
			end,
			set = function(_, value)
				Memento.db.profile.events.achievement.personal.active = value
			end,
			width = "full",
			order = 0.13
		},
		personalExist = {
			type = "toggle",
			name = L["options.event.achievement.personal.exist.name"],
			desc = L["options.event.achievement.personal.exist.desc"],
			disabled = function()
				return not Memento.db.profile.events.achievement.personal.active
			end,
			get = function()
				return Memento.db.profile.events.achievement.personal.exist
			end,
			set = function(_, value)
				Memento.db.profile.events.achievement.personal.exist = value
			end,
			width = "full",
			order = 0.14
		},
		personalTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.achievement.personal"], 2),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.achievement.personal.active
			end,
			get = function()
				return Memento.db.profile.events.achievement.personal.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.achievement.personal.timer = value
			end,
			order = 0.15
		},
		LINE_2 = Memento_GetStyleLineNormal(0.16),
		SEPARATOR_2 = Memento_GetStyleSeparatorText(0.17, " " .. L["options.event.achievement.criteria"]),
		criteriaActive = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.achievement.criteria"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.achievement.criteria"]),
			get = function()
				return Memento.db.profile.events.achievement.criteria.active
			end,
			set = function(_, value)
				Memento.db.profile.events.achievement.criteria.active = value
			end,
			width = "full",
			order = 0.18
		},
		criteriaTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.achievement.criteria"], 2),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.achievement.criteria.active
			end,
			get = function()
				return Memento.db.profile.events.achievement.criteria.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.achievement.criteria.timer = value
			end,
			order = 0.19
		},
		LINE_3 = Memento_GetStyleLineNormal(0.20),
		SEPARATOR_3 = Memento_GetStyleSeparatorText(0.21, " " .. L["options.event.achievement.guild"]),
		guildActive = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.achievement.guild"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.achievement.guild"]),
			get = function()
				return Memento.db.profile.events.achievement.guild.active
			end,
			set = function(_, value)
				Memento.db.profile.events.achievement.guild.active = value
			end,
			width = "full",
			order = 0.22
		},
		guildTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.achievement.guild"], 2),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.achievement.guild.active
			end,
			get = function()
				return Memento.db.profile.events.achievement.guild.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.achievement.guild.timer = value
			end,
			order = 0.23
		},
		LINE_4 = Memento_GetStyleLineNormal(0.24)
	},
}

Memento.optionsTable["eventAchievement-cata"] = {
	name = L["options.event.achievement"],
	type = "group",
	order = orderID,
	args = {
		LINE_1 = Memento_GetStyleLineSmall(0.11),
		SEPARATOR_1  = Memento_GetStyleSeparatorText(0.12, " " .. L["options.event.achievement.personal"]),
		personalActive = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.achievement.personal"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.achievement.personal"]),
			get = function()
				return Memento.db.profile.events.achievement.personal.active
			end,
			set = function(_, value)
				Memento.db.profile.events.achievement.personal.active = value
			end,
			width = "full",
			order = 0.13
		},
		personalExist = {
			type = "toggle",
			name = L["options.event.achievement.personal.exist.name"],
			desc = L["options.event.achievement.personal.exist.desc"],
			disabled = function()
				return not Memento.db.profile.events.achievement.personal.active
			end,
			get = function()
				return Memento.db.profile.events.achievement.personal.exist
			end,
			set = function(_, value)
				Memento.db.profile.events.achievement.personal.exist = value
			end,
			width = "full",
			order = 0.14
		},
		personalTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.achievement.personal"], 2),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.achievement.personal.active
			end,
			get = function()
				return Memento.db.profile.events.achievement.personal.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.achievement.personal.timer = value
			end,
			order = 0.15
		},
		LINE_2 = Memento_GetStyleLineNormal(0.16),
		SEPARATOR_2  = Memento_GetStyleSeparatorText(0.17, " " .. L["options.event.achievement.guild"]),
		guildActive = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.achievement.guild"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.achievement.guild"]),
			get = function()
				return Memento.db.profile.events.achievement.guild.active
			end,
			set = function(_, value)
				Memento.db.profile.events.achievement.guild.active = value
			end,
			width = "full",
			order = 0.18
		},
		guildTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.achievement.guild"], 2),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.achievement.guild.active
			end,
			get = function()
				return Memento.db.profile.events.achievement.guild.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.achievement.guild.timer = value
			end,
			order = 0.19
		},
		LINE_4 = Memento_GetStyleLineNormal(0.20),
	},
}