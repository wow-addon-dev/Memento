local addonName, Memento = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

Memento.optionsTable = Memento.optionsTable or {}

Memento.optionsTable["info"] = {
	name =  addonName,
	type = "group",
	args = {
		description = {
			name = L["info.description"],
			type = "group",
			inline = true,
			order = 1.1,
			args = {
				content_1 = {
					name = L["info.description.content_1"],
					type = "description",
					width = "full",
					fontSize = "medium",
					order = 0.11
				},
				content_2 = {
					name = L["info.description.content_2"],
					type = "description",
					width = "full",
					fontSize = "small",
					order = 0.12
				},
				LINE_1 = Memento_GetStyleLineSmall(0.13),
			},
		},
		help = {
			name = L["info.help"],
			type = "group",
			inline = true,
			order = 1.2,
			args = {
				description = {
					name = L["info.help.description"],
					type = "description",
					width = "full",
					fontSize = "medium",
					order = 0.11
				},
				SEPARATOR_1 = Memento_GetStyleSeparator(0.12),
				options = {
					name = L["info.help.options.name"],
					type = "execute",
					width = 1.2,
					desc = L["info.help.options.desc"],
					confirm = true,
					confirmText = L["info.help.options.confirmText"],
					func = function()
						Memento.db:ResetDB()
						Memento:PrintMessage(L["chat.reset.options.success"])
					end,
					order = 0.13
				},
			},
		},
		about = {
			name = L["info.about"],
			type = "group",
			inline = true,
			order = 1.3,
			args = {
				build = {
					name = Memento_MarkGoldFont(L["info.about.game-version"] .. ": ") .. Memento.gameVersion .. " (".. Memento.flavor .. ")",
					type = "description",
					width = "full",
					fontSize = "medium",
					order = 0.11
				},
				version = {
					name = Memento_MarkGoldFont(L["info.about.addon-version"] .. ": ") .. Memento.addonVersion .. " (".. Memento.buildDate .. ")",
					type = "description",
					width = "full",
					fontSize = "medium",
					order = 0.12
				},
				LINE_1 = Memento_GetStyleLineNormal(0.13),
				author = {
					name =  Memento_MarkGoldFont(L["info.about.author"] .. ": ") .. Memento.author,
					type = "description",
					width = "full",
					fontSize = "medium",
					order = 0.14
				},
				SEPARATOR_1 = Memento_GetStyleSeparator(0.15),
				feedback = {
					name = L["info.about.feedback"],
					type = "description",
					width = "full",
					fontSize = "small",
					order = 0.16
				},
				LINE_2 = Memento_GetStyleLineSmall(0.17),
				--[[email = {
					name = L["info.about.email.name"],
					type = "execute",
					width = 1.2,
					desc = L["info.about.email.desc"],
					func = function()
						LibStub("Memento_PopupDialog-1.0").ShowDialogExternalLink(Memento.eMail, L["info.about.email.popup"])
					end,
					order = 0.18
				},
				SPACE_1 = {
					name = "",
					type = "description",
					width = 0.2,
					fontSize = "medium",
					order = 0.19
				}, ]]
				github = {
					name = L["info.about.github.name"],
					type = "execute",
					width = 1.2,
					desc = L["info.about.github.desc"],
					func = function()
						LibStub("Memento_PopupDialog-1.0").ShowDialogExternalLink(Memento.github, L["info.about.github.popup"])
					end,
					order = 0.20
				},
			},
		},
	},
}
