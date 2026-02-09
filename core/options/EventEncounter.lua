local addonName, Memento = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local orderID = 2.13

Memento.optionsTable = Memento.optionsTable or {}

Memento.optionsTable["eventEncounter-mainline"] = {
	name = L["options.event.encounter"],
	type = "group",
	order = orderID,
	args = {
		LINE_1 = Memento_GetStyleLineSmall(0.11),
		SEPARATOR_1 = Memento_GetStyleSeparatorText(0.12, " " .. L["options.event.encounter.victory"]),
		victoryParty = {
			name = L["options.event.encounter.party.name"],
			desc = L["options.event.encounter.victory.party.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.victory.party
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.party = value
			end,
			width = "normal",
			order = 0.13
		},
		victoryRaid = {
			name = L["options.event.encounter.raid.name"],
			desc = L["options.event.encounter.victory.raid.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.victory.raid
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.raid = value
			end,
			width = "normal",
			order = 0.14
		},
		victoryScenario = {
			name = L["options.event.encounter.scenario.name"],
			desc = L["options.event.encounter.victory.scenario.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.victory.scenario
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.scenario = value
			end,
			width = "normal",
			order = 0.15
		},
		victoryFirst = {
			name = L["options.event.encounter.victory.first.name"],
			desc = L["options.event.encounter.victory.first.desc"],
			type = "toggle",
			disabled = function()
				return ((not Memento.db.profile.events.encounter.victory.party) and (not Memento.db.profile.events.encounter.victory.raid) and (not Memento.db.profile.events.encounter.victory.scenario))
			end,
			get = function()
				return Memento.db.profile.events.encounter.victory.first
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.first = value
			end,
			width = "full",
			order = 0.16
		},
		victoryTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.encounter.victory"], 2),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return ((not Memento.db.profile.events.encounter.victory.party) and (not Memento.db.profile.events.encounter.victory.raid) and (not Memento.db.profile.events.encounter.victory.scenario))
			end,
			get = function()
				return Memento.db.profile.events.encounter.victory.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.timer = value
			end,
			order = 0.17
		},
		LINE_2 = Memento_GetStyleLineNormal(0.18),
		SEPARATOR_2 = Memento_GetStyleSeparatorText(0.19, " " .. L["options.event.encounter.wipe"]),
		wipeParty = {
			name = L["options.event.encounter.party.name"],
			desc = L["options.event.encounter.wipe.party.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.wipe.party
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.wipe.party = value
			end,
			width = "normal",
			order = 0.20
		},
		wipeRaid = {
			name = L["options.event.encounter.raid.name"],
			desc = L["options.event.encounter.wipe.raid.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.wipe.raid
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.wipe.raid = value
			end,
			width = "normal",
			order = 0.21
		},
		wipeScenario = {
			name = L["options.event.encounter.scenario.name"],
			desc = L["options.event.encounter.wipe.scenario.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.wipe.scenario
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.wipe.scenario = value
			end,
			width = "normal",
			order = 0.22
		},
		wipeTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.encounter.wipe"], 2),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return ((not Memento.db.profile.events.encounter.wipe.party) and (not Memento.db.profile.events.encounter.wipe.raid) and (not Memento.db.profile.events.encounter.wipe.scenario))
			end,
			get = function()
				return Memento.db.profile.events.encounter.wipe.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.wipe.timer = value
			end,
			order = 0.23
		},
		LINE_3 = Memento_GetStyleLineNormal(0.24),
	},
}

Memento.optionsTable["eventEncounter-mists"] = {
	name = L["options.event.encounter"],
	type = "group",
	order = orderID,
	args = {
		LINE_1 = Memento_GetStyleLineSmall(0.11),
		SEPARATOR_1 = Memento_GetStyleSeparatorText(0.12, " " .. L["options.event.encounter.victory"]),
		victoryParty = {
			name = L["options.event.encounter.party.name"],
			desc = L["options.event.encounter.victory.party.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.victory.party
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.party = value
			end,
			width = "normal",
			order = 0.13
		},
		victoryRaid = {
			name = L["options.event.encounter.raid.name"],
			desc = L["options.event.encounter.victory.raid.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.victory.raid
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.raid = value
			end,
			width = "double",
			order = 0.14
		},
		victoryFirst = {
			name = L["options.event.encounter.victory.first.name"],
			desc = L["options.event.encounter.victory.first.desc"],
			type = "toggle",
			disabled = function()
				return ((not Memento.db.profile.events.encounter.victory.party) and (not Memento.db.profile.events.encounter.victory.raid) and (not Memento.db.profile.events.encounter.victory.scenario))
			end,
			get = function()
				return Memento.db.profile.events.encounter.victory.first
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.first = value
			end,
			width = "full",
			order = 0.15
		},
		victoryTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.encounter.victory"], 2),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return ((not Memento.db.profile.events.encounter.victory.party) and (not Memento.db.profile.events.encounter.victory.raid) and (not Memento.db.profile.events.encounter.victory.scenario))
			end,
			get = function()
				return Memento.db.profile.events.encounter.victory.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.timer = value
			end,
			order = 0.16
		},
		LINE_2 = Memento_GetStyleLineNormal(0.17),
		SEPARATOR_2 = Memento_GetStyleSeparatorText(0.18, " " .. L["options.event.encounter.wipe"]),
		wipeParty = {
			name = L["options.event.encounter.party.name"],
			desc = L["options.event.encounter.wipe.party.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.wipe.party
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.wipe.party = value
			end,
			width = "normal",
			order = 0.19
		},
		wipeRaid = {
			name = L["options.event.encounter.raid.name"],
			desc = L["options.event.encounter.wipe.raid.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.wipe.raid
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.wipe.raid = value
			end,
			width = "double",
			order = 0.20
		},
		wipeTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.encounter.wipe"], 2),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return ((not Memento.db.profile.events.encounter.wipe.party) and (not Memento.db.profile.events.encounter.wipe.raid) and (not Memento.db.profile.events.encounter.wipe.scenario))
			end,
			get = function()
				return Memento.db.profile.events.encounter.wipe.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.wipe.timer = value
			end,
			order = 0.21
		},
		LINE_3 = Memento_GetStyleLineNormal(0.22),
	},
}

Memento.optionsTable["eventEncounter-cata"] = {
	name = L["options.event.encounter"],
	type = "group",
	order = orderID,
	args = {
		LINE_1 = Memento_GetStyleLineSmall(0.11),
		SEPARATOR_1 = Memento_GetStyleSeparatorText(0.12, " " .. L["options.event.encounter.victory"]),
		victoryParty = {
			name = L["options.event.encounter.party.name"],
			desc = L["options.event.encounter.victory.party.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.victory.party
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.party = value
			end,
			width = "normal",
			order = 0.13
		},
		victoryRaid = {
			name = L["options.event.encounter.raid.name"],
			desc = L["options.event.encounter.victory.raid.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.victory.raid
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.raid = value
			end,
			width = "double",
			order = 0.14
		},
		victoryFirst = {
			name = L["options.event.encounter.victory.first.name"],
			desc = L["options.event.encounter.victory.first.desc"],
			type = "toggle",
			disabled = function()
				return ((not Memento.db.profile.events.encounter.victory.party) and (not Memento.db.profile.events.encounter.victory.raid) and (not Memento.db.profile.events.encounter.victory.scenario))
			end,
			get = function()
				return Memento.db.profile.events.encounter.victory.first
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.first = value
			end,
			width = "full",
			order = 0.15
		},
		victoryTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.encounter.victory"], 2),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return ((not Memento.db.profile.events.encounter.victory.party) and (not Memento.db.profile.events.encounter.victory.raid) and (not Memento.db.profile.events.encounter.victory.scenario))
			end,
			get = function()
				return Memento.db.profile.events.encounter.victory.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.timer = value
			end,
			order = 0.16
		},
		LINE_2 = Memento_GetStyleLineNormal(0.17),
		SEPARATOR_2 = Memento_GetStyleSeparatorText(0.18, " " .. L["options.event.encounter.wipe"]),
		wipeParty = {
			name = L["options.event.encounter.party.name"],
			desc = L["options.event.encounter.wipe.party.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.wipe.party
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.wipe.party = value
			end,
			width = "normal",
			order = 0.19
		},
		wipeRaid = {
			name = L["options.event.encounter.raid.name"],
			desc = L["options.event.encounter.wipe.raid.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.wipe.raid
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.wipe.raid = value
			end,
			width = "double",
			order = 0.20
		},
		wipeTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.encounter.wipe"], 2),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return ((not Memento.db.profile.events.encounter.wipe.party) and (not Memento.db.profile.events.encounter.wipe.raid) and (not Memento.db.profile.events.encounter.wipe.scenario))
			end,
			get = function()
				return Memento.db.profile.events.encounter.wipe.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.wipe.timer = value
			end,
			order = 0.21
		},
		LINE_3 = Memento_GetStyleLineNormal(0.22),
	},
}

Memento.optionsTable["eventEncounter-tbc"] = {
	name = L["options.event.encounter"],
	type = "group",
	order = orderID,
	args = {
		LINE_1 = Memento_GetStyleLineSmall(0.11),
		SEPARATOR_1 = Memento_GetStyleSeparatorText(0.12, " " .. L["options.event.encounter.victory"]),
		victoryParty = {
			name = L["options.event.encounter.party.name"],
			desc = L["options.event.encounter.victory.party.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.victory.party
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.party = value
			end,
			width = "normal",
			order = 0.13
		},
		victoryRaid = {
			name = L["options.event.encounter.raid.name"],
			desc = L["options.event.encounter.victory.raid.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.victory.raid
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.raid = value
			end,
			width = "double",
			order = 0.14
		},
		victoryFirst = {
			name = L["options.event.encounter.victory.first.name"],
			desc = L["options.event.encounter.victory.first.desc"],
			type = "toggle",
			disabled = function()
				return ((not Memento.db.profile.events.encounter.victory.party) and (not Memento.db.profile.events.encounter.victory.raid) and (not Memento.db.profile.events.encounter.victory.scenario))
			end,
			get = function()
				return Memento.db.profile.events.encounter.victory.first
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.first = value
			end,
			width = "full",
			order = 0.15
		},
		victoryTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.encounter.victory"], 2),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return ((not Memento.db.profile.events.encounter.victory.party) and (not Memento.db.profile.events.encounter.victory.raid) and (not Memento.db.profile.events.encounter.victory.scenario))
			end,
			get = function()
				return Memento.db.profile.events.encounter.victory.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.timer = value
			end,
			order = 0.16
		},
		LINE_2 = Memento_GetStyleLineNormal(0.17),
		SEPARATOR_2 = Memento_GetStyleSeparatorText(0.18, " " .. L["options.event.encounter.wipe"]),
		wipeParty = {
			name = L["options.event.encounter.party.name"],
			desc = L["options.event.encounter.wipe.party.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.wipe.party
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.wipe.party = value
			end,
			width = "normal",
			order = 0.19
		},
		wipeRaid = {
			name = L["options.event.encounter.raid.name"],
			desc = L["options.event.encounter.wipe.raid.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.wipe.raid
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.wipe.raid = value
			end,
			width = "double",
			order = 0.20
		},
		wipeTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.encounter.wipe"], 2),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return ((not Memento.db.profile.events.encounter.wipe.party) and (not Memento.db.profile.events.encounter.wipe.raid) and (not Memento.db.profile.events.encounter.wipe.scenario))
			end,
			get = function()
				return Memento.db.profile.events.encounter.wipe.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.wipe.timer = value
			end,
			order = 0.21
		},
		LINE_3 = Memento_GetStyleLineNormal(0.22),
	},
}

Memento.optionsTable["eventEncounter-vanilla"] = {
	name = L["options.event.encounter"],
	type = "group",
	order = orderID,
	args = {
		LINE_1 = Memento_GetStyleLineSmall(0.11),
		SEPARATOR_1 = Memento_GetStyleSeparatorText(0.12, " " .. L["options.event.encounter.victory"]),
		victoryParty = {
			name = L["options.event.encounter.party.name"],
			desc = L["options.event.encounter.victory.party.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.victory.party
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.party = value
			end,
			width = "normal",
			order = 0.13
		},
		victoryRaid = {
			name = L["options.event.encounter.raid.name"],
			desc = L["options.event.encounter.victory.raid.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.victory.raid
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.raid = value
			end,
			width = "double",
			order = 0.14
		},
		victoryFirst = {
			name = L["options.event.encounter.victory.first.name"],
			desc = L["options.event.encounter.victory.first.desc"],
			type = "toggle",
			disabled = function()
				return ((not Memento.db.profile.events.encounter.victory.party) and (not Memento.db.profile.events.encounter.victory.raid) and (not Memento.db.profile.events.encounter.victory.scenario))
			end,
			get = function()
				return Memento.db.profile.events.encounter.victory.first
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.first = value
			end,
			width = "full",
			order = 0.15
		},
		victoryTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.encounter.victory"], 2),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return ((not Memento.db.profile.events.encounter.victory.party) and (not Memento.db.profile.events.encounter.victory.raid) and (not Memento.db.profile.events.encounter.victory.scenario))
			end,
			get = function()
				return Memento.db.profile.events.encounter.victory.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.victory.timer = value
			end,
			order = 0.16
		},
		LINE_2 = Memento_GetStyleLineNormal(0.17),
		SEPARATOR_2 = Memento_GetStyleSeparatorText(0.18, " " .. L["options.event.encounter.wipe"]),
		wipeParty = {
			name = L["options.event.encounter.party.name"],
			desc = L["options.event.encounter.wipe.party.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.wipe.party
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.wipe.party = value
			end,
			width = "normal",
			order = 0.19
		},
		wipeRaid = {
			name = L["options.event.encounter.raid.name"],
			desc = L["options.event.encounter.wipe.raid.desc"],
			type = "toggle",
			get = function()
				return Memento.db.profile.events.encounter.wipe.raid
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.wipe.raid = value
			end,
			width = "double",
			order = 0.20
		},
		wipeTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.encounter.wipe"], 2),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return ((not Memento.db.profile.events.encounter.wipe.party) and (not Memento.db.profile.events.encounter.wipe.raid) and (not Memento.db.profile.events.encounter.wipe.scenario))
			end,
			get = function()
				return Memento.db.profile.events.encounter.wipe.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.encounter.wipe.timer = value
			end,
			order = 0.21
		},
		LINE_3 = Memento_GetStyleLineNormal(0.22),
	},
}
