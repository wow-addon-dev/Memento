local addonName, Memento = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

Memento.optionsTable = Memento.optionsTable or {}

Memento.optionsTable["statistic-mainline"] = {
	name =  "|T" .. Memento.MEDIA_PATH .. "icon_options.blp:0:0:0:1|t  " .. addonName .. " - " .. L["statistic"],
	type = "group",
	args = {
		screenshots = {
			name = L["statistic.screenshots"],
			type = "group",
			inline = true,
			order = 1.1,
			args = {
				description = {
					name = L["statistic.screenshots.description"],
					type = "description",
					width = "full",
					fontSize = "medium",
					order = 0.11
				},
				SEPARATOR_1 = Memento_GetStyleSeparator(0.12),
				personalAchievementName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.achievement.personal"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.13
				},
				personalAchievementCount = {
					name = function ()
						return Memento.dbStatstic.global.events.achievement.personal.count .. " (" .. Memento.dbStatstic.char.events.achievement.personal.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.14
				},
				LINE_1 = Memento_GetStyleLineSmall(0.15),
				criteriaAchievementName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.achievement.criteria"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.16
				},
				criteriaAchievementCount = {
					name = function ()
						return Memento.dbStatstic.global.events.achievement.criteria.count .. " (" .. Memento.dbStatstic.char.events.achievement.criteria.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.17
				},
				LINE_2 = Memento_GetStyleLineSmall(0.18),
				guildAchievementName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.achievement.guild"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.19
				},
				guildAchievementCount = {
					name = function ()
						return Memento.dbStatstic.global.events.achievement.guild.count .. " (" .. Memento.dbStatstic.char.events.achievement.guild.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.20
				},
				LINE_3 = Memento_GetStyleLineNormal(0.21),
				encounterVictoryName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.encounter.victory"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.22
				},
				encounterVictoryCount = {
					name = function ()
						return Memento.dbStatstic.global.events.encounter.victory.count .. " (" .. Memento.dbStatstic.char.events.encounter.victory.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.23
				},
				LINE_4 = Memento_GetStyleLineSmall(0.24),
				encounterWipeName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.encounter.wipe"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.25
				},
				encounterWipeCount = {
					name = function ()
						return Memento.dbStatstic.global.events.encounter.wipe.count .. " (" .. Memento.dbStatstic.char.events.encounter.wipe.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.26
				},
				LINE_5 = Memento_GetStyleLineNormal(0.27),
				pvpDuelName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.pvp.duel"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.28
				},
				pvpDuelCount = {
					name = function ()
						return Memento.dbStatstic.global.events.pvp.duel.count .. " (" .. Memento.dbStatstic.char.events.pvp.duel.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.29
				},
				LINE_6 = Memento_GetStyleLineSmall(0.30),
				pvpArenaName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.pvp.arena"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.31
				},
				pvpArenaCount = {
					name = function ()
						return Memento.dbStatstic.global.events.pvp.arena.count .. " (" .. Memento.dbStatstic.char.events.pvp.arena.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.32
				},
				LINE_7 = Memento_GetStyleLineSmall(0.33),
				pvpBattlegoundName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.pvp.battleground"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.34
				},
				pvpBattlegoundCount = {
					name = function ()
						return Memento.dbStatstic.global.events.pvp.battleground.count .. " (" .. Memento.dbStatstic.char.events.pvp.battleground.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.35
				},
				LINE_8 = Memento_GetStyleLineSmall(0.36),
				pvpBrawlName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.pvp.brawl"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.37
				},
				pvpBrawlCount = {
					name = function ()
						return Memento.dbStatstic.global.events.pvp.brawl.count .. " (" .. Memento.dbStatstic.char.events.pvp.brawl.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.38
				},
				LINE_9 = Memento_GetStyleLineNormal(0.39),
				levelUpName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.levelUp"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.40
				},
				levelUpCount = {
					name = function ()
						return Memento.dbStatstic.global.events.levelUp.count .. " (" .. Memento.dbStatstic.char.events.levelUp.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.41
				},
				LINE_10 = Memento_GetStyleLineSmall(0.42),
				deathName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.death"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.43
				},
				deathCount = {
					name = function ()
						return Memento.dbStatstic.global.events.death.count .. " (" .. Memento.dbStatstic.char.events.death.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.44
				},
				LINE_11 = Memento_GetStyleLineSmall(0.45),
				loginName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.login"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.46
				},
				loginCount = {
					name = function ()
						return Memento.dbStatstic.global.events.login.count .. " (" .. Memento.dbStatstic.char.events.login.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.47
				},
				LINE_12 = Memento_GetStyleLineSmall(0.48),
			},
		},
	},
}

Memento.optionsTable["statistic-cata"] = {
	name =  "|T" .. Memento.MEDIA_PATH .. "icon_options.blp:0:0:0:2|t  " .. addonName .. " - " .. L["statistic"],
	type = "group",
	args = {
		screenshots = {
			name = L["statistic.screenshots"],
			type = "group",
			inline = true,
			order = 1.1,
			args = {
				description = {
					name = L["statistic.screenshots.description"],
					type = "description",
					width = "full",
					fontSize = "medium",
					order = 0.11
				},
				SEPARATOR_1 = Memento_GetStyleSeparator(0.12),
				personalAchievementName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.achievement.personal"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.13
				},
				personalAchievementCount = {
					name = function ()
						return Memento.dbStatstic.global.events.achievement.personal.count .. " (" .. Memento.dbStatstic.char.events.achievement.personal.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.14
				},
				LINE_1 = Memento_GetStyleLineSmall(0.15),
				guildAchievementName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.achievement.guild"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.16
				},
				guildAchievementCount = {
					name = function ()
						return Memento.dbStatstic.global.events.achievement.guild.count .. " (" .. Memento.dbStatstic.char.events.achievement.guild.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.17
				},
				LINE_2 = Memento_GetStyleLineNormal(0.18),
				encounterVictoryName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.encounter.victory"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.19
				},
				encounterVictoryCount = {
					name = function ()
						return Memento.dbStatstic.global.events.encounter.victory.count .. " (" .. Memento.dbStatstic.char.events.encounter.victory.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.20
				},
				LINE_3 = Memento_GetStyleLineSmall(0.21),
				encounterWipeName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.encounter.wipe"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.22
				},
				encounterWipeCount = {
					name = function ()
						return Memento.dbStatstic.global.events.encounter.wipe.count .. " (" .. Memento.dbStatstic.char.events.encounter.wipe.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.23
				},
				LINE_4 = Memento_GetStyleLineNormal(0.24),
				pvpDuelName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.pvp.duel"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.25
				},
				pvpDuelCount = {
					name = function ()
						return Memento.dbStatstic.global.events.pvp.duel.count .. " (" .. Memento.dbStatstic.char.events.pvp.duel.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.26
				},
				LINE_5 = Memento_GetStyleLineNormal(0.27),
				levelUpName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.levelUp"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.28
				},
				levelUpCount = {
					name = function ()
						return Memento.dbStatstic.global.events.levelUp.count .. " (" .. Memento.dbStatstic.char.events.levelUp.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.29
				},
				LINE_6 = Memento_GetStyleLineSmall(0.30),
				deathName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.death"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.31
				},
				deathCount = {
					name = function ()
						return Memento.dbStatstic.global.events.death.count .. " (" .. Memento.dbStatstic.char.events.death.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.32
				},
				LINE_7 = Memento_GetStyleLineSmall(0.33),
				loginName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.login"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.34
				},
				loginCount = {
					name = function ()
						return Memento.dbStatstic.global.events.login.count .. " (" .. Memento.dbStatstic.char.events.login.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.35
				},
				LINE_8 = Memento_GetStyleLineSmall(0.36),
			},
		},
	},
}

Memento.optionsTable["statistic-vanilla"] = {
	name =  "|T" .. Memento.MEDIA_PATH .. "icon_options.blp:0:0:0:2|t  " .. addonName .. " - " .. L["statistic"],
	type = "group",
	args = {
		screenshots = {
			name = L["statistic.screenshots"],
			type = "group",
			inline = true,
			order = 1.1,
			args = {
				description = {
					name = L["statistic.screenshots.description"],
					type = "description",
					width = "full",
					fontSize = "medium",
					order = 0.11
				},
				SEPARATOR_1 = Memento_GetStyleSeparator(0.12),
				encounterVictoryName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.encounter.victory"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.13
				},
				encounterVictoryCount = {
					name = function ()
						return Memento.dbStatstic.global.events.encounter.victory.count .. " (" .. Memento.dbStatstic.char.events.encounter.victory.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.14
				},
				LINE_1 = Memento_GetStyleLineSmall(0.15),
				encounterWipeName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.encounter.wipe"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.16
				},
				encounterWipeCount = {
					name = function ()
						return Memento.dbStatstic.global.events.encounter.wipe.count .. " (" .. Memento.dbStatstic.char.events.encounter.wipe.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.17
				},
				LINE_2 = Memento_GetStyleLineNormal(0.18),
				pvpDuelName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.pvp.duel"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.19
				},
				pvpDuelCount = {
					name = function ()
						return Memento.dbStatstic.global.events.pvp.duel.count .. " (" .. Memento.dbStatstic.char.events.pvp.duel.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.20
				},
				LINE_3 = Memento_GetStyleLineNormal(0.21),
				levelUpName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.levelUp"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.22
				},
				levelUpCount = {
					name = function ()
						return Memento.dbStatstic.global.events.levelUp.count .. " (" .. Memento.dbStatstic.char.events.levelUp.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.23
				},
				LINE_4 = Memento_GetStyleLineSmall(0.24),
				deathName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.death"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.25
				},
				deathCount = {
					name = function ()
						return Memento.dbStatstic.global.events.death.count .. " (" .. Memento.dbStatstic.char.events.death.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.26
				},
				LINE_5 = Memento_GetStyleLineSmall(0.27),
				loginName = {
					name = Memento_MarkGoldFont(L["statistic.screenshots.login"]),
					type = "description",
					width = 1.25,
					fontSize = "medium",
					order = 0.28
				},
				loginCount = {
					name = function ()
						return Memento.dbStatstic.global.events.login.count .. " (" .. Memento.dbStatstic.char.events.login.count .. ")"
					end,
					type = "description",
					width = 1,
					fontSize = "medium",
					order = 0.29
				},
				LINE_6 = Memento_GetStyleLineSmall(0.30),
			},
		},
	},
}
