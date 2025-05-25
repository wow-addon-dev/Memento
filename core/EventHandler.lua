local addonName, Memento = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

------------------------
--- Public functions ---
------------------------

function Memento:AchievementPersonalEventHandler(achievementID, alreadyEarned)
    if not alreadyEarned then
        self:PrintMessage(L["chat.event.achievement.personal.new"]:format(GetAchievementLink(achievementID)))
        self:TakeScreenshot(Memento.EVENT_ACHIEVEMENT_EARNED_PERSONAL)
    elseif self.db.profile.events.achievement.personal.exist then
        self:PrintMessage(L["chat.event.achievement.personal.exist"]:format(GetAchievementLink(achievementID)))
        self:TakeScreenshot(Memento.EVENT_ACHIEVEMENT_EARNED_PERSONAL)
    else
        self:PrintDebug("The achievement ".. GetAchievementLink(achievementID) .. " has already been reached by another character. No screenshot requested.")
    end
end

function Memento:CriteriaEventHandler(achievementID, description)
    self:PrintMessage(L["chat.event.achievement.criteria.new"]:format(GetAchievementLink(achievementID), description))
    self:TakeScreenshot(Memento.EVENT_ACHIEVEMENT_CRITERIA_EARNED)
end

function Memento:AchievementGuildEventHandler(achievementID)
    local name = select(2, GetAchievementInfo(achievementID))

    self:PrintMessage(L["chat.event.achievement.guild.new"]:format(name))
    self:TakeScreenshot(Memento.EVENT_ACHIEVEMENT_EARNED_GUILD)
end

function Memento:EncounterVictoryEventHandler(encounterName, difficultyName, difficulty, encounterID)
	self:PrintMessage(L["chat.event.encounter.victory.new"]:format(encounterName, difficultyName))
    self:TakeScreenshot(Memento.EVENT_ENCOUNTER_END_VICTORY)

    Memento_DataBossKill[difficulty][encounterID] = true
end

function Memento:EncounterWipeEventHandler(encounterName, difficultyName)
	self:PrintMessage(L["chat.event.encounter.wipe.new"]:format(encounterName, difficultyName))
    self:TakeScreenshot(Memento.EVENT_ENCOUNTER_END_WIPE)
end

function Memento:PvPDuelEventHandler()
	self:PrintMessage(L["chat.event.pvp.duel.new"])
    self:TakeScreenshot(Memento.EVENT_DUEL_FINISHED)
end

function Memento:PvPArenaEventHandler()
	self:PrintMessage(L["chat.event.pvp.arena.new"])
    self:TakeScreenshot(Memento.EVENT_PVP_MATCH_COMPLETE_ARENA)
end

function Memento:PvPBattlegroundEventHandler()
	self:PrintMessage(L["chat.event.pvp.battleground.new"])
    self:TakeScreenshot(Memento.EVENT_PVP_MATCH_COMPLETE_BATTLEGROUND)
end

function Memento:PvPBrawlEventHandler()
	self:PrintMessage(L["chat.event.pvp.brawl.new"])
    self:TakeScreenshot(Memento.EVENT_PVP_MATCH_COMPLETE_BRAWL)
end

function Memento:LevelUpEventHandler(level)
	self:PrintMessage(L["chat.event.levelUp.new"]:format(Memento_GetLevelUpLink(level)))
    self:TakeScreenshot(Memento.EVENT_PLAYER_LEVEL_UP)
end

function Memento:DeathEventHandler()
	self:PrintMessage(L["chat.event.death.new"])
    self:TakeScreenshot(Memento.EVENT_PLAYER_DEAD)
end

function Memento:LoginEventHandler()
    self:PrintMessage(L["chat.event.login.new"])
    self:TakeScreenshot(Memento.EVENT_PLAYER_LOGIN)
end
