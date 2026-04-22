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
L["options.general.notification-timestamp.name"] = "Chat output with timestamp"
L["options.general.notification-timestamp.tooltip"] = "Activate or deactivate the chat output with timestamp when a screenshot has been taken."
L["options.general.notification-class.name"] = "Chat output of the class"
L["options.general.notification-class.tooltip"] = "Activate or deactivate the chat output of the class when a screenshot has been taken."
L["options.general.notification-time-played.name"] = "Chat output of the total time played"
L["options.general.notification-time-played.tooltip"] = "Activate or deactivate the chat output of the total time played when a screenshot has been taken."
L["options.general.hide-ui.name"] = "Hide user interface for screenshot"
L["options.general.hide-ui.tooltip"] = "Activate or deactivate the option to hide the user interface for the screenshot. A small success notification is displayed instead.\n\nNote: The user interface cannot be hidden automatically during a combat. In this case, the screenshot is taken with the user interface."
L["options.general.minimap-button.name"] = "Minimap Button"
L["options.general.minimap-button.tooltip"] = "When this is enabled, the minimap button is displayed."

L["options.event"] = "Events"
L["options.event.general.active.tooltip"] = "Activate or deactivate the automatic creation of a screenshot for the event %s."
L["options.event.general.delay.name"] = "Delay"
L["options.event.general.delay.tooltip"] = "The time delay of the screenshot after the event %s was triggered.\n\nDefault: %d second(s)"

L["options.event.login"] = "Player Login"

L["options.event.interval"] = "Regular Interval"

L["options.event.interval-timer.name"] = "Interval"
L["options.event.interval-timer.tooltip"] = "The time interval at which a screenshot is taken.\n\nDefault: 5 Minutes"

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

L["minimap-button.tooltip"] = "|cnLINK_FONT_COLOR:Left-click|r to open the gold and currency overview.\n|cnLINK_FONT_COLOR:Right-click|r to open the options."

L["general.seconds-short"] = "sec"
L["general.minutes-short"] = "min"

-- Chat

L["chat.notification.class"] = "Class: %s"
L["chat.notification.timePlayed"] = "Total time played: %d days, %d hours, %d minutes, %d seconds"

L["chat.event.login.new"] = "Screenshot taken - |cffF2E699Player Login|r"
L["chat.event.interval.new"] = "Screenshot taken - |cffF2E699Regular Interval|r"

-- Capture

L["capture.message"] = "Screenshot taken"

--- OLD ENTRIES - CAN BE DELETED IN THE FUTURE

local eventColor = "ffF2E699"






L["options.event.achievement"] = "Achievements"
L["options.event.achievement.personal"] = "Personal Achievement"
L["options.event.achievement.personal.exist.name"] = "Take a screenshot if a personal achievement has already been reached"
L["options.event.achievement.personal.exist.desc"] = "Activate or deactivate the creation of a screenshot if an personal achievement has already been reached by another character."
L["options.event.achievement.criteria"] = "Personal Achievement Criteria"
L["options.event.achievement.guild"] = "Guild Achievement"

L["options.event.encounter"] = "Boss Fight"
L["options.event.encounter.victory"] = "Boss Fight - Victory"
L["options.event.encounter.wipe"] = "Boss Fight - Wipe"
L["options.event.encounter.party.name"] = "Dungeon"
L["options.event.encounter.raid.name"] = "Raid"
L["options.event.encounter.scenario.name"] = "Scenario / Delve"

L["options.event.encounter.victory.party.desc"] = "Activate or deactivate the automatic creation of a screenshot when you have killed a dungeon boss."
L["options.event.encounter.victory.raid.desc"] = "Activate or deactivate the automatic creation of a screenshot when you have killed a raid boss."
L["options.event.encounter.victory.scenario.desc"] = "Activate or deactivate the automatic creation of a screenshot when you have killed a scenario or delves boss."
L["options.event.encounter.victory.first.name"] = "only on the first kill per difficulty"
L["options.event.encounter.victory.first.desc"] = "Activate or deactivate the automatic creation of a screenshot when you have already killed a boss. This option applies separately for each difficulty."
L["options.event.encounter.wipe.party.desc"] = "Activate or deactivate the automatic creation of a screenshot when you have wiped at a dungeon boss."
L["options.event.encounter.wipe.raid.desc"] = "Activate or deactivate the automatic creation of a screenshot when you have wiped at a raid boss."
L["options.event.encounter.wipe.scenario.desc"] = "Activate or deactivate the automatic creation of a screenshot when you have wiped at a scenario or delves boss."

L["options.event.pvp"] = "Player vs. Player"
L["options.event.pvp.duel"] = "PvP - Duel finished"
L["options.event.pvp.arena"] = "PvP - Arena completed"
L["options.event.pvp.battleground"] = "PvP - Battleground completed"
L["options.event.pvp.brawl"] = "PvP - Brawl completed"

L["options.event.levelUp"] = "Level-Up"

L["options.event.death"] = "Player Death"
L["options.event.death.instance.name"] = "Screenshot behavior in instances"
L["options.event.death.instance.desc"] = "Screenshots are only created inside and / or outside an instance, depending on the following settings for |c" .. eventColor .. "player death|r.\n\nAn instance includes arenas, battlegrounds, raids or dungeons."
L["options.event.death.instance.option.0"] = "inside and outside of instances"
L["options.event.death.instance.option.1"] = "only inside of instances"
L["options.event.death.instance.option.2"] = "only outside of instances"

L["options.event.pvp.victory.name"] = "only in the event of a victory"
L["options.event.pvp.victory.desc"] = "Activate or deactivate the automatic creation of a screenshot when you have won the PVP match."



L["options.event.warbandCollection"] = "Warband Collections"
L["options.event.warbandCollection.newPet"] = "New Pet"
L["options.event.warbandCollection.newMount"] = "New Mount"
L["options.event.warbandCollection.newToy"] = "New Toy"
L["options.event.warbandCollection.newRecipe"] = "New Recipe"
L["options.event.warbandCollection.newHousingItem"] = "New Housing Item"



L["options.event.mythic"] = "Mythic+ Dungeon"



L["chat.level.name"] = "Level"


L["chat.event.achievement.personal.new"] = "Screenshot taken - |c" .. eventColor .. "Personal Achievement|r - %s"
L["chat.event.achievement.personal.exist"] = "Screenshot taken - |c" .. eventColor .. "Personal Achievement|r - %s (has already been reached by another character)"
L["chat.event.achievement.criteria.new"] = "Screenshot taken - |c" .. eventColor .. "Personal Achievement|r - %s - %s"
L["chat.event.achievement.guild.new"] = "Screenshot taken - |c" .. eventColor .. "Guild achievement|r - %s"
L["chat.event.encounter.victory.new"] = "Screenshot taken - |c" .. eventColor .. "Boss Fight - Victory|r - %s (%s)"
L["chat.event.encounter.wipe.new"] = "Screenshot taken - |c" .. eventColor .. "Boss Fight - Wipe|r - %s (%s)"
L["chat.event.pvp.duel.new"] = "Screenshot taken - |c" .. eventColor .. "PvP - Duel finished|r"
L["chat.event.pvp.arena.new"] = "Screenshot taken - |c" .. eventColor .. "PvP - Arena completed|r"
L["chat.event.pvp.battleground.new"] = "Screenshot taken - |c" .. eventColor .. "PvP - Battleground completed|r"
L["chat.event.pvp.brawl.new"] = "Screenshot taken - |c" .. eventColor .. "PvP - Brawl completed|r"
L["chat.event.levelUp.new"] = "Screenshot taken - |c" .. eventColor .. "Level-Up|r - %s"
L["chat.event.death.new"] = "Screenshot taken - |c" .. eventColor .. "Player Death|r"

L["chat.event.warbandCollection.newPet.new"] = "Screenshot taken - |c" .. eventColor .. "New Pet|r"
L["chat.event.warbandCollection.newMount.new"] = "Screenshot taken - |c" .. eventColor .. "New Mount|r"
L["chat.event.warbandCollection.newToy.new"] = "Screenshot taken - |c" .. eventColor .. "New Toy|r"
L["chat.event.warbandCollection.newRecipe.new"] = "Screenshot taken - |c" .. eventColor .. "New Recipe|r"
L["chat.event.warbandCollection.newHousingItem.new"] = "Screenshot taken - |c" .. eventColor .. "New Housing Item|r"

L["chat.event.mythic.new"] = "Screenshot taken - |c" .. eventColor .. "Mythic+ Dungeon|r"

