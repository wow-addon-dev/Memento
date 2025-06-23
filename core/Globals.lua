local addonName, Memento = ...

Memento.MEDIA_PATH = "Interface\\AddOns\\" .. addonName .. "\\media\\"

local flavor = C_AddOns.GetAddOnMetadata(addonName, "X-Flavor")

Memento.FLAVOR_IS_MAINLINE = flavor == "Retail"
Memento.FLAVOR_IS_MISTS = flavor == "Mists"
Memento.FLAVOR_IS_CATA = flavor == "Cata"
Memento.FLAVOR_IS_VANILLA = flavor == "Classic"

Memento.COLOR_NORMAL_FONT = "ffFFD200"
Memento.COLOR_WHITE_FONT = "ffFFFFFF"
Memento.COLOR_ORANGE_FONT = "ffFF8040"
Memento.COLOR_GOLD_FONT = "ffF2E699"

Memento.EVENT_ACHIEVEMENT_EARNED_PERSONAL = 1
Memento.EVENT_ACHIEVEMENT_CRITERIA_EARNED = 2
Memento.EVENT_ACHIEVEMENT_EARNED_GUILD = 3
Memento.EVENT_ENCOUNTER_END_VICTORY = 4
Memento.EVENT_ENCOUNTER_END_WIPE = 5
Memento.EVENT_DUEL_FINISHED = 6
Memento.EVENT_PVP_MATCH_COMPLETE_ARENA = 7
Memento.EVENT_PVP_MATCH_COMPLETE_BATTLEGROUND = 8
Memento.EVENT_PVP_MATCH_COMPLETE_BRAWL = 9
Memento.EVENT_PLAYER_LEVEL_UP = 10
Memento.EVENT_PLAYER_DEAD = 11
Memento.EVENT_PLAYER_LOGIN = 12
