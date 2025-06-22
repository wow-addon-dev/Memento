local addonName, Memento = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local orderID = 2.4

Memento.optionsTable = Memento.optionsTable or {}

Memento.optionsTable["eventPvP-mainline"] = {
	name = L["options.event.pvp"],
	type = "group",
	order = orderID,
	args = {
		LINE_1 = Memento_GetStyleLineSmall(0.11),
		SEPARATOR_1 = Memento_GetStyleSeparatorText(0.12, " " .. L["options.event.pvp.duel"]),
		duelActive = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.pvp.duel"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.pvp.duel"]),
			get = function()
				return Memento.db.profile.events.pvp.duel.active
			end,
			set = function(_, value)
				Memento.db.profile.events.pvp.duel.active = value
			end,
			width = "full",
			order = 0.13
		},
		duelTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.pvp.duel"], 1),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.pvp.duel.active
			end,
			get = function()
				return Memento.db.profile.events.pvp.duel.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.pvp.duel.timer = value
			end,
			order = 0.14
		},
		LINE_2 = Memento_GetStyleLineNormal(0.15),
		SEPARATOR_2 = Memento_GetStyleSeparatorText(0.16, " " .. L["options.event.pvp.arena"]),
		arenaActive = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.pvp.arena"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.pvp.arena"]),
			get = function()
				return Memento.db.profile.events.pvp.arena.active
			end,
			set = function(_, value)
				Memento.db.profile.events.pvp.arena.active = value
			end,
			width = "full",
			order = 0.17
		},
		arenaTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.pvp.arena"], 3),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.pvp.arena.active
			end,
			get = function()
				return Memento.db.profile.events.pvp.arena.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.pvp.arena.timer = value
			end,
			order = 0.18
		},
		LINE_3 = Memento_GetStyleLineNormal(0.19),
		SEPARATOR_3 = Memento_GetStyleSeparatorText(0.20, " " .. L["options.event.pvp.battleground"]),
		battlegroundActive = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.pvp.battleground"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.pvp.battleground"]),
			get = function()
				return Memento.db.profile.events.pvp.battleground.active
			end,
			set = function(_, value)
				Memento.db.profile.events.pvp.battleground.active = value
			end,
			width = "full",
			order = 0.21
		},
		battlegroundVictoryOnly = {
			name = L["options.event.pvp.victory.name"],
			desc = L["options.event.pvp.victory.desc"],
			type = "toggle",
			disabled = function()
				return not Memento.db.profile.events.pvp.battleground.active
			end,
			get = function()
				return Memento.db.profile.events.pvp.battleground.victory
			end,
			set = function(_, value)
				Memento.db.profile.events.pvp.battleground.victory = value
			end,
			width = "full",
			order = 0.22
		},
		battlegroundTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.pvp.battleground"], 3),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.pvp.battleground.active
			end,
			get = function()
				return Memento.db.profile.events.pvp.battleground.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.pvp.battleground.timer = value
			end,
			order = 0.23
		},
		LINE_4 = Memento_GetStyleLineNormal(0.24),
		SEPARATOR_4 = Memento_GetStyleSeparatorText(0.25, " " .. L["options.event.pvp.brawl"]),
		brawlActive = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.pvp.brawl"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.pvp.brawl"]),
			get = function()
				return Memento.db.profile.events.pvp.brawl.active
			end,
			set = function(_, value)
				Memento.db.profile.events.pvp.brawl.active = value
			end,
			width = "full",
			order = 0.26
		},
		brawlVictoryOnly = {
			name = L["options.event.pvp.victory.name"],
			desc = L["options.event.pvp.victory.desc"],
			type = "toggle",
			disabled = function()
				return not Memento.db.profile.events.pvp.brawl.active
			end,
			get = function()
				return Memento.db.profile.events.pvp.brawl.victory
			end,
			set = function(_, value)
				Memento.db.profile.events.pvp.brawl.victory = value
			end,
			width = "full",
			order = 0.27
		},
		brawlTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.pvp.brawl"], 3),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.pvp.brawl.active
			end,
			get = function()
				return Memento.db.profile.events.pvp.brawl.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.pvp.brawl.timer = value
			end,
			order = 0.28
		},
		LINE_5 = Memento_GetStyleLineNormal(0.29),
	},
}

Memento.optionsTable["eventPvP-mists"] = {
	name = L["options.event.pvp"],
	type = "group",
	order = orderID,
	args = {
		LINE_1 = Memento_GetStyleLineSmall(0.11),
		SEPARATOR_1 = Memento_GetStyleSeparatorText(0.12, " " .. L["options.event.pvp.duel"]),
		duelActive = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.pvp.duel"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.pvp.duel"]),
			get = function()
				return Memento.db.profile.events.pvp.duel.active
			end,
			set = function(_, value)
				Memento.db.profile.events.pvp.duel.active = value
			end,
			width = "full",
			order = 0.13
		},
		duelTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.pvp.duel"], 1),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.pvp.duel.active
			end,
			get = function()
				return Memento.db.profile.events.pvp.duel.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.pvp.duel.timer = value
			end,
			order = 0.14
		},
		LINE_2 = Memento_GetStyleLineNormal(0.15),
	},
}

Memento.optionsTable["eventPvP-cata"] = {
	name = L["options.event.pvp"],
	type = "group",
	order = orderID,
	args = {
		LINE_1 = Memento_GetStyleLineSmall(0.11),
		SEPARATOR_1 = Memento_GetStyleSeparatorText(0.12, " " .. L["options.event.pvp.duel"]),
		duelActive = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.pvp.duel"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.pvp.duel"]),
			get = function()
				return Memento.db.profile.events.pvp.duel.active
			end,
			set = function(_, value)
				Memento.db.profile.events.pvp.duel.active = value
			end,
			width = "full",
			order = 0.13
		},
		duelTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.pvp.duel"], 1),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.pvp.duel.active
			end,
			get = function()
				return Memento.db.profile.events.pvp.duel.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.pvp.duel.timer = value
			end,
			order = 0.14
		},
		LINE_2 = Memento_GetStyleLineNormal(0.15),
	},
}

Memento.optionsTable["eventPvP-vanilla"] = {
	name = L["options.event.pvp"],
	type = "group",
	order = orderID,
	args = {
		LINE_1 = Memento_GetStyleLineSmall(0.11),
		SEPARATOR_1 = Memento_GetStyleSeparatorText(0.12, " " .. L["options.event.pvp.duel"]),
		duelActive = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.pvp.duel"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.pvp.duel"]),
			get = function()
				return Memento.db.profile.events.pvp.duel.active
			end,
			set = function(_, value)
				Memento.db.profile.events.pvp.duel.active = value
			end,
			width = "full",
			order = 0.13
		},
		duelTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.pvp.duel"], 1),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.pvp.duel.active
			end,
			get = function()
				return Memento.db.profile.events.pvp.duel.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.pvp.duel.timer = value
			end,
			order = 0.14
		},
		LINE_2 = Memento_GetStyleLineNormal(0.15),
	},
}
