local addonName, Memento = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local orderID = 2.1

Memento.optionsTable = Memento.optionsTable or {}

Memento.optionsTable["options"] = {
	name =  function()
		if Memento.FLAVOR_IS_MAINLINE then
			return "|T" .. Memento.MEDIA_PATH .. "icon_options.blp:0:0:0:1|t  " .. addonName .. " - " .. L["options"]
		else
			return "|T" .. Memento.MEDIA_PATH .. "icon_options.blp:0:0:0:2|t  " .. addonName .. " - " .. L["options"]
		end
	end,
	type = "group",
	childGroups = "tab",
	args = {
		general = {
			name = L["options.general"],
			type = "group",
			inline = true,
			order = orderID,
			args = {
				notification = {
					type = "toggle",
					name = L["options.general.notification.name"],
					desc = L["options.general.notification.desc"],
					get = function()
						return Memento.db.profile.options.notification.active
					end,
					set = function(_, value)
						Memento.db.profile.options.notification.active = value
					end,
					width = "full",
					order = 0.11
				},
				class = {
					type = "toggle",
					name = L["options.general.notification.class.name"],
					desc = L["options.general.notification.class.desc"],
					disabled = function()
						return not Memento.db.profile.options.notification.active
					end,
					get = function()
						return Memento.db.profile.options.notification.class
					end,
					set = function(_, value)
						Memento.db.profile.options.notification.class = value
					end,
					width = "full",
					order = 0.12
				},
				timePlayed = {
					type = "toggle",
					name = L["options.general.notification.timePlayed.name"],
					desc = L["options.general.notification.timePlayed.desc"],
					disabled = function()
						return not Memento.db.profile.options.notification.active
					end,
					get = function()
						return Memento.db.profile.options.notification.timePlayed
					end,
					set = function(_, value)
						Memento.db.profile.options.notification.timePlayed = value
					end,
					width = "full",
					order = 0.13
				},
				SEPARATOR_2 = Memento_GetStyleSeparator(0.14),
				statistic = {
					type = "toggle",
					name = L["options.general.statistic.name"],
					desc = L["options.general.statistic.desc"],
					get = function()
						return Memento.db.profile.options.statistic
					end,
					set = function(_, value)
						Memento.db.profile.options.statistic = value
					end,
					width = "full",
					order = 0.15
				},
				ui = {
					type = "toggle",
					name = L["options.general.ui.name"],
					desc = L["options.general.ui.desc"],
					get = function()
						return Memento.db.profile.options.ui
					end,
					set = function(_, value)
						Memento.db.profile.options.ui = value
					end,
					width = "full",
					order = 0.16
				},
				SEPARATOR_1 = Memento_GetStyleSeparator(0.17),
				debug = {
					type = "toggle",
					name = L["options.general.debug.name"],
					desc = L["options.general.debug.desc"],
					get = function()
						return Memento.db.profile.options.debug
					end,
					set = function(_, value)
						Memento.db.profile.options.debug = value
					end,
					width = "full",
					order = 0.18
				},
			},
		},
	},
}
