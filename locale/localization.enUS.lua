local _, MEM = ...

MEM.Localization = setmetatable({},{__index=function(self,key)
        geterrorhandler()("Memento (Debug): Missing entry for '" .. tostring(key) .. "'")
        return key
    end})

local L = MEM.Localization

-- Options

L["options.general"] = "General Options"
L["options.general.notification.name"] = "Chat notification"
L["options.general.notification.tooltip"] = "Activate or deactivate the notification in the chat when a screenshot has been taken."
L["options.general.notification.timestamp.name"] = "Chat output with timestamp"
L["options.general.notification.timestamp.tooltip"] = "Activate or deactivate the chat output with timestamp when a screenshot has been taken."
L["options.general.notification.class.name"] = "Chat output of the class"
L["options.general.notification.class.tooltip"] = "Activate or deactivate the chat output of the class when a screenshot has been taken."
L["options.general.notification.time-played.name"] = "Chat output of the total time played"
L["options.general.notification.time-played.tooltip"] = "Activate or deactivate the chat output of the total time played when a screenshot has been taken."
L["options.general.hide-ui.name"] = "Hide user interface for screenshot"
L["options.general.hide-ui.tooltip"] = "Activate or deactivate the option to hide the user interface for the screenshot. A small success notification is displayed instead.\n\nNote: The user interface cannot be hidden automatically during a combat. In this case, the screenshot is taken with the user interface."
L["options.general.minimap-button.name"] = "Minimap Button"
L["options.general.minimap-button.tooltip"] = "When this is enabled, the minimap button is displayed."

L["options.event.general.active.tooltip"] = "Activate or deactivate the automatic creation of a screenshot for the event %s."
L["options.event.general.delay.name"] = "Delay"
L["options.event.general.delay.tooltip"] = "The time delay of the screenshot after the event %s was triggered.\n\nDefault: %d second(s)"

L["options.event"] = "Screenshots"

L["options.event.achievement"] = "Achievements"
L["options.event.achievement.personal"] = "Personal Achievement"
L["options.event.achievement.personal.exist.name"] = "Take a screenshot if a personal achievement has already been reached"
L["options.event.achievement.personal.exist.tooltip"] = "Activate or deactivate the creation of a screenshot if an personal achievement has already been reached by another character."
L["options.event.achievement.criteria"] = "Personal Achievement Criteria"
L["options.event.achievement.guild"] = "Guild Achievement"

L["options.event.encounter"] = "Boss Fight"
L["options.event.encounter.victory"] = "Victory"
L["options.event.encounter.wipe"] = "Wipe"
L["options.event.encounter.party"] = "Dungeon"
L["options.event.encounter.raid"] = "Raid"
L["options.event.encounter.scenario"] = "Scenario / Delve"
L["options.event.encounter.victory.first.name"] = "first kill per difficulty"
L["options.event.encounter.victory.first.tooltip"] = "Activate or deactivate the automatic creation of a screenshot when you have already killed a boss. This option applies separately for each difficulty."
L["options.event.encounter.victory.party.tooltip"] = "Activate or deactivate the automatic creation of a screenshot when you have killed a dungeon boss."
L["options.event.encounter.victory.raid.tooltip"] = "Activate or deactivate the automatic creation of a screenshot when you have killed a raid boss."
L["options.event.encounter.victory.scenario.tooltip"] = "Activate or deactivate the automatic creation of a screenshot when you have killed a scenario or delves boss."
L["options.event.encounter.wipe.party.tooltip"] = "Activate or deactivate the automatic creation of a screenshot when you have wiped at a dungeon boss."
L["options.event.encounter.wipe.raid.tooltip"] = "Activate or deactivate the automatic creation of a screenshot when you have wiped at a raid boss."
L["options.event.encounter.wipe.scenario.tooltip"] = "Activate or deactivate the automatic creation of a screenshot when you have wiped at a scenario or delves boss."

L["options.event.pvp"] = "Player vs. Player"
L["options.event.pvp.duel"] = "Duel finished"
L["options.event.pvp.arena"] = "Arena completed"
L["options.event.pvp.battleground"] = "Battleground completed"
L["options.event.pvp.brawl"] = "Brawl completed"
L["options.event.pvp.victory.name"] = "only in the event of a victory"
L["options.event.pvp.victory.tooltip"] = "Activate or deactivate the automatic creation of a screenshot when you have won the PVP match."

L["options.event.warband-collection"] = "Warband Collections"
L["options.event.warband-collection.new-pet"] = "New Pet"
L["options.event.warband-collection.new-mount"] = "New Mount"
L["options.event.warband-collection.new-toy"] = "New Toy"
L["options.event.warband-collection.new-recipe"] = "New Recipe"
L["options.event.warband-collection.new-housing-item"] = "New Housing Item"

L["options.event.other"] = "Other"
L["options.event.other.login"] = "Player Login"
L["options.event.other.level-up"] = "Level-Up"
L["options.event.other.death"] = "Player Death"
L["options.event.other.death.instance.name"] = "Screenshot behavior in instances"
L["options.event.other.death.instance.tooltip"] = "Screenshots are only created inside and / or outside an instance, depending on the following settings for player death.\n\nAn instance includes arenas, battlegrounds, raids or dungeons."
L["options.event.other.death.instance.option.0"] = "inside and outside of instances"
L["options.event.other.death.instance.option.1"] = "only inside of instances"
L["options.event.other.death.instance.option.2"] = "only outside of instances"
L["options.event.other.mythic"] = "Mythic+ Dungeon"
L["options.event.other.interval"] = "Regular Interval"
L["options.event.other.interval-timer.name"] = "Interval"
L["options.event.other.interval-timer.tooltip"] = "The time interval at which a screenshot is taken.\n\nDefault: 5 Minutes"

L["options.other"] = "Other Options"
L["options.other.debug-mode.name"] = "Debug Mode"
L["options.other.debug-mode.tooltip"] = "Enabling the debug mode displays additional information in the chat."

L["options.about"] = "About"
L["options.about.game-version"] = "Game Version"
L["options.about.addon-version"] = "Addon Version"
L["options.about.lib-version"] = "Library Version"
L["options.about.author"] = "Author"

L["options.about.button-github.name"] = "Feedback & Help"
L["options.about.button-github.tooltip"] = "Opens a popup window with a link to GitHub."
L["options.about.button-github.button"] = "GitHub"

-- General

L["minimap-button.tooltip"] = "|cnLINK_FONT_COLOR:Right-click|r to open the options."

L["general.seconds-short"] = "sec"
L["general.minutes-short"] = "min"

-- Chat

L["chat.notification.class"] = "Class: %s"
L["chat.notification.time-played"] = "Total time played: %d days, %d hours, %d minutes, %d seconds"

L["chat.event.achievement.personal.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:Personal Achievement|r - %s"
L["chat.event.achievement.personal.exist"] = "Screenshot taken - |cnGOLD_FONT_COLOR:Personal Achievement|r - %s (has already been reached by another character)"
L["chat.event.achievement.personal.no-link.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:Personal Achievement|r"
L["chat.event.achievement.personal.no-link.exist"] = "Screenshot taken - |cnGOLD_FONT_COLOR:Personal Achievement|r (has already been reached by another character)"
L["chat.event.achievement.criteria.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:Personal Achievement Criteria|r - %s - %s"
L["chat.event.achievement.criteria.no-link.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:Personal Achievement Criteria|r"
L["chat.event.achievement.guild.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:Guild achievement|r - %s"

L["chat.event.encounter.victory.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:Boss Fight - Victory|r - %s (%s)"
L["chat.event.encounter.wipe.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:Boss Fight - Wipe|r - %s (%s)"

L["chat.event.pvp.duel.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:PvP - Duel finished|r"
L["chat.event.pvp.arena.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:PvP - Arena completed|r"
L["chat.event.pvp.battleground.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:PvP - Battleground completed|r"
L["chat.event.pvp.brawl.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:PvP - Brawl completed|r"

L["chat.event.warband-collection.new-pet.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:New Pet|r"
L["chat.event.warband-collection.new-mount.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:New Mount|r"
L["chat.event.warband-collection.new-toy.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:New Toy|r"
L["chat.event.warband-collection.new-recipe.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:New Recipe|r"
L["chat.event.warband-collection.new-housing-item.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:New Housing Item|r"

L["chat.event.login.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:Player Login|r"
L["chat.event.level-up.retail.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:Level-Up|r - |cffFF4E00|Hlevelup:%1$s:LEVEL_UP_TYPE_CHARACTER|h[Level %1$s]|h|r"
L["chat.event.level-up.classic.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:Level-Up|r - |cffFF4E00[Level %1$s]|r"
L["chat.event.death.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:Player Death|r"
L["chat.event.mythic.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:Mythic+ Dungeon|r"
L["chat.event.interval.new"] = "Screenshot taken - |cnGOLD_FONT_COLOR:Regular Interval|r"

-- Capture

L["capture.message"] = "Screenshot taken"
