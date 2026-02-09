local addonName, Memento = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local orderID = 2.18

Memento.optionsTable = Memento.optionsTable or {}

Memento.optionsTable["eventWarbandCollection"] = {
	name = L["options.event.warbandCollection"],
	type = "group",
	order = orderID,
	args = {
		LINE_1 = Memento_GetStyleLineSmall(0.11),
		SEPARATOR_1  = Memento_GetStyleSeparatorText(0.12, " " .. L["options.event.warbandCollection.newPet"]),
		newPetActive = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.warbandCollection.newPet"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.warbandCollection.newPet"]),
			get = function()
				return Memento.db.profile.events.warbandCollection.newPet.active
			end,
			set = function(_, value)
				Memento.db.profile.events.warbandCollection.newPet.active = value
			end,
			width = "full",
			order = 0.13
		},
		newPetTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.warbandCollection.newPet"], 1),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.warbandCollection.newPet.active
			end,
			get = function()
				return Memento.db.profile.events.warbandCollection.newPet.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.warbandCollection.newPet.timer = value
			end,
			order = 0.14
		},
		LINE_2 = Memento_GetStyleLineNormal(0.15),
		SEPARATOR_2 = Memento_GetStyleSeparatorText(0.16, " " .. L["options.event.warbandCollection.newMount"]),
		newMountActive = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.warbandCollection.newMount"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.warbandCollection.newMount"]),
			get = function()
				return Memento.db.profile.events.warbandCollection.newMount.active
			end,
			set = function(_, value)
				Memento.db.profile.events.warbandCollection.newMount.active = value
			end,
			width = "full",
			order = 0.17
		},
		criteriaTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.warbandCollection.newMount"], 1),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.warbandCollection.newMount.active
			end,
			get = function()
				return Memento.db.profile.events.warbandCollection.newMount.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.warbandCollection.newMount.timer = value
			end,
			order = 0.18
		},
		LINE_3 = Memento_GetStyleLineNormal(0.19),
		SEPARATOR_3 = Memento_GetStyleSeparatorText(0.20, " " .. L["options.event.warbandCollection.newToy"]),
		newToyActive = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.warbandCollection.newToy"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.warbandCollection.newToy"]),
			get = function()
				return Memento.db.profile.events.warbandCollection.newToy.active
			end,
			set = function(_, value)
				Memento.db.profile.events.warbandCollection.newToy.active = value
			end,
			width = "full",
			order = 0.21
		},
		newToyTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.warbandCollection.newToy"], 1),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.warbandCollection.newToy.active
			end,
			get = function()
				return Memento.db.profile.events.warbandCollection.newToy.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.warbandCollection.newToy.timer = value
			end,
			order = 0.22
		},
		LINE_4 = Memento_GetStyleLineNormal(0.23),
		SEPARATOR_4 = Memento_GetStyleSeparatorText(0.24, " " .. L["options.event.warbandCollection.newRecipe"]),
		newRecipeActive = {
			type = "toggle",
			name = L["options.event.general.active.name"]:format(L["options.event.warbandCollection.newRecipe"]),
			desc = L["options.event.general.active.desc"]:format(L["options.event.warbandCollection.newRecipe"]),
			get = function()
				return Memento.db.profile.events.warbandCollection.newRecipe.active
			end,
			set = function(_, value)
				Memento.db.profile.events.warbandCollection.newRecipe.active = value
			end,
			width = "full",
			order = 0.25
		},
		newRecipeTimer = {
			name = L["options.event.general.delay.name"],
			desc = L["options.event.general.delay.desc"]:format(L["options.event.warbandCollection.newRecipe"], 1),
			type = "range",
			min = 0,
			max = 10,
			step = 1,
			disabled = function()
				return not Memento.db.profile.events.warbandCollection.newRecipe.active
			end,
			get = function()
				return Memento.db.profile.events.warbandCollection.newRecipe.timer
			end,
			set = function(_, value)
				Memento.db.profile.events.warbandCollection.newRecipe.timer = value
			end,
			order = 0.26
		},
		LINE_5 = Memento_GetStyleLineNormal(0.27)
	},
}
