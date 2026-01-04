local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local Memento = LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")

Memento.addonVersion = C_AddOns.GetAddOnMetadata(addonName, "Version")
Memento.author = C_AddOns.GetAddOnMetadata(addonName, "Author")
Memento.flavor = C_AddOns.GetAddOnMetadata(addonName, "X-Flavor")
Memento.buildDate = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate")
Memento.eMail = C_AddOns.GetAddOnMetadata(addonName, "X-E-Mail")
Memento.github = C_AddOns.GetAddOnMetadata(addonName, "X-Github")

Memento.gameVersion = GetBuildInfo()

Memento.totalTimePlayed = 0
Memento.timePlayedThisLevel = 0

local fixDelay = 0.1
local lastEventTime = 0
local requestTimePlayed
local orignalChatFrame = ChatFrame_DisplayTimePlayed

ChatFrame_DisplayTimePlayed = function(...)
	if requestTimePlayed then
		requestTimePlayed = false
	else
		orignalChatFrame(...)
	end
end

-----------------------
--- Local functions ---
-----------------------

local function TimePlayed()
    local currentTime = GetTime()

    if currentTime - lastEventTime >= 5 and (Memento.db.profile.options.notification.class or Memento.db.profile.options.notification.timePlayed) then
        lastEventTime = currentTime
        requestTimePlayed = true

        RequestTimePlayed()
    end
end

---------------------
--- Main funtions ---
---------------------

function Memento:OnInitialize()
    self:SetupAddon()

    self:RegisterEvent(
        "TIME_PLAYED_MSG",
        function(_, totalTimePlayed, timePlayedThisLevel)
            self:PrintDebug("Event 'TIME_PLAYED_MSG' fired. Payload: totalTimePlayed=" .. tostring(totalTimePlayed) .. ", timePlayedThisLevel=" .. tostring(timePlayedThisLevel))

            Memento.totalTimePlayed = totalTimePlayed
            Memento.timePlayedThisLevel = timePlayedThisLevel

            self:PrintDebug("Event 'TIME_PLAYED_MSG' completed.")
        end
    )

    self:PrintDebug("Event 'TIME_PLAYED_MSG' registered.")

    if Memento.FLAVOR_IS_MAINLINE or Memento.FLAVOR_IS_CATA or Memento.FLAVOR_IS_MISTS then
        self:RegisterEvent(
            "ACHIEVEMENT_EARNED",
            function(_, achievementID, alreadyEarned)
                self:PrintDebug("Event 'ACHIEVEMENT_EARNED' fired. Payload: achievementID=" .. achievementID .. ", alreadyEarned=" .. tostring(alreadyEarned))

                local isGuildAchievement = select(12, GetAchievementInfo(achievementID))

                if not isGuildAchievement then
                    if self.db.profile.events.achievement.personal.active then
                        TimePlayed()

                        self:ScheduleTimer("AchievementPersonalEventHandler", self.db.profile.events.achievement.personal.timer + fixDelay, achievementID, alreadyEarned)
                    else
                        self:PrintDebug("Event 'ACHIEVEMENT_EARNED' (Personal) completed. No screenshot requested.")
                    end
                else
                    if self.db.profile.events.achievement.guild.active then
                        TimePlayed()

                        self:ScheduleTimer("AchievementGuildEventHandler", self.db.profile.events.achievement.guild.timer + fixDelay, achievementID)
                    else
                        self:PrintDebug("Event 'ACHIEVEMENT_EARNED' (Guild) completed. No screenshot requested.")
                    end
            	end
            end
        )

        self:PrintDebug("Event 'ACHIEVEMENT_EARNED' registered. (Retail / Cata)")
    end

    if Memento.FLAVOR_IS_MAINLINE then
        self:RegisterEvent(
            "CRITERIA_EARNED",
            function(_, achievementID, description)
                self:PrintDebug("Event 'CRITERIA_EARNED' fired. Payload: achievementID=" .. tostring(achievementID) .. ", description=" .. tostring(description))

                if self.db.profile.events.achievement.criteria.active then
                    TimePlayed()

                    self:ScheduleTimer("CriteriaEventHandler", self.db.profile.events.achievement.criteria.timer + fixDelay, achievementID, description)
                else
                    self:PrintDebug("Event 'CRITERIA_EARNED' completed. No screenshot requested.")
                end
            end
        )

        self:PrintDebug("Event 'CRITERIA_EARNED' registered. (Retail)")
    end

    self:RegisterEvent(
        "ENCOUNTER_END",
        function(_, encounterID, encounterName, difficultyID, groupSize, success)
            self:PrintDebug("Event 'ENCOUNTER_END' fired. Payload: encounterID=" .. encounterID .. ", encounterName=" .. encounterName .. ", difficultyID=" .. difficultyID .. ", groupSize=" .. groupSize .. ", success=" .. success)

            local difficultyName, groupType = GetDifficultyInfo(difficultyID)
            local difficulty = "D" .. difficultyID

            if groupType == "party" or groupType == "raid" or groupType == "scenario" then
                if success == 1 then
                    if ((groupType == "party" and self.db.profile.events.encounter.victory.party) or (groupType == "raid" and self.db.profile.events.encounter.victory.raid) or (groupType == "scenario" and self.db.profile.events.encounter.victory.scenario)) then
                        if (not Memento_DataBossKill[difficulty]) then
                            Memento_DataBossKill[difficulty] = {}
                        end

                        if (Memento_DataBossKill[difficulty][encounterID] and self.db.profile.events.encounter.victory.first) then
                            self:PrintDebug("Encounter already killed. No screenshot requested.")
                        else
                            TimePlayed()

                            self:ScheduleTimer("EncounterVictoryEventHandler", self.db.profile.events.encounter.victory.timer + fixDelay, encounterName, difficultyName, difficulty, encounterID)
                        end
                    else
                        self:PrintDebug("Event 'ENCOUNTER_END' (Victory) completed. No screenshot requested.")
                    end
                else
                    if((groupType == "party" and self.db.profile.events.encounter.wipe.party) or (groupType == "raid" and self.db.profile.events.encounter.wipe.raid) or (groupType == "scenario" and self.db.profile.events.encounter.wipe.scenario)) then
                        TimePlayed()

                        self:ScheduleTimer("EncounterWipeEventHandler", self.db.profile.events.encounter.wipe.timer + fixDelay, encounterName, difficultyName)
                    else
                        self:PrintDebug("Event 'ENCOUNTER_END' (Wipe) completed. No screenshot requested.")
                    end
                end
            else
                self:PrintDebug("Unknown groupType '" .. tostring(groupType) .. "'. No screenshot requested.")
            end
        end
    )

    self:PrintDebug("Event 'ENCOUNTER_END' registered.")

    self:RegisterEvent(
        "DUEL_FINISHED",
        function()
            self:PrintDebug("Event 'DUEL_FINISHED' fired. No payload.")

            if self.db.profile.events.pvp.duel.active then
                TimePlayed()

                self:ScheduleTimer("PvPDuelEventHandler", self.db.profile.events.pvp.duel.timer + fixDelay)
            else
                self:PrintDebug("Event 'DUEL_FINISHED' completed. No screenshot requested.")
            end
        end
    )

    self:PrintDebug("Event 'DUEL_FINISHED' registered.")

    if Memento.FLAVOR_IS_MAINLINE then
        self:RegisterEvent(
            "PVP_MATCH_COMPLETE",
            function(_, winner, duration)
                self:PrintDebug("Event \"PVP_MATCH_COMPLETE\" fired. Payload: winner=" .. tostring(winner) .. ", duration=" .. tostring(duration))

                local isArena = C_PvP.IsArena()
                local isBattleground = C_PvP.IsBattleground()
				local isSoloRBG = C_PvP.IsSoloRBG()
                local isInBrawl = C_PvP.IsInBrawl()
                local playerFaction = UnitFactionGroup("player")

                if isArena then
                    if self.db.profile.events.pvp.arena.active then
                        TimePlayed()

                        self:ScheduleTimer("PvPArenaEventHandler", self.db.profile.events.pvp.battleground.timer + fixDelay)
                    else
                        self:PrintDebug("Event 'PVP_MATCH_COMPLETE' (Arean) completed. No screenshot requested.")
                    end
                elseif isBattleground or isSoloRBG then
                    if self.db.profile.events.pvp.battleground.active then
                        if self.db.profile.events.pvp.battleground.victory then
                            if (playerFaction == "Alliance" and winner == 1) or (playerFaction == "Horde" and winner == 0) then
                                TimePlayed()

                                self:ScheduleTimer("PvPBattlegroundEventHandler", self.db.profile.events.pvp.battleground.timer + fixDelay)
                            else
                                self:PrintDebug("Player faction has lost the battleground. No screenshot requested.")
                            end
                        else
                            TimePlayed()

                            self:ScheduleTimer("PvPBattlegroundEventHandler", self.db.profile.events.pvp.battleground.timer + fixDelay)
                        end
                    else
                        self:PrintDebug("Event 'PVP_MATCH_COMPLETE' (Battleground) completed. No screenshot requested.")
                    end
                elseif isInBrawl then
                    if self.db.profile.events.pvp.brawl.active then
                        if self.db.profile.events.pvp.brawl.victory then
                            if (playerFaction == "Alliance" and winner == 1) or (playerFaction == "Horde" and winner == 0) then
                                TimePlayed()

                                self:ScheduleTimer("PvPBrawlEventHandler", self.db.profile.events.pvp.brawl.timer + fixDelay)
                            else
                                self:PrintDebug("Player faction has lost the brawl. No screenshot requested.")
                            end
                        else
                            TimePlayed()

                            self:ScheduleTimer("PvPBrawlEventHandler", self.db.profile.events.pvp.brawl.timer + fixDelay)
                        end
                    else
                        self:PrintDebug("Event 'PVP_MATCH_COMPLETE' (Brawl) completed. No screenshot requested.")
                    end
                else
                    self:PrintDebug("Unknown PvP Event. No screenshot requested.")
                end
            end
        )

        self:PrintDebug("Event 'PVP_MATCH_COMPLETE' registered. (Retail)")
    end

    self:RegisterEvent(
        "PLAYER_LEVEL_UP",
        function(_, level)
            self:PrintDebug("Event 'PLAYER_LEVEL_UP' fired. Payload: level=" .. level)

            if self.db.profile.events.levelUp.active then
                TimePlayed()

                self:ScheduleTimer("LevelUpEventHandler", self.db.profile.events.levelUp.timer + fixDelay, level)
            else
                self:PrintDebug("Event 'PLAYER_LEVEL_UP' completed. No screenshot requested.")
            end
        end
    )

    self:PrintDebug("Event 'PLAYER_LEVEL_UP' registered.")

    self:RegisterEvent(
        "PLAYER_DEAD",
        function()
            self:PrintDebug("Event 'PLAYER_DEAD' fired. No payload.")

            if self.db.profile.events.death.active then
                TimePlayed()

                local inInstance, instanceType = IsInInstance()

                if self.db.profile.events.death.instance == 0 then
                    self:ScheduleTimer("DeathEventHandler", self.db.profile.events.death.timer + fixDelay)
                elseif inInstance and self.db.profile.events.death.instance == 1 then
                    self:ScheduleTimer("DeathEventHandler", self.db.profile.events.death.timer + fixDelay)
                elseif not inInstance and self.db.profile.events.death.instance == 2 then
                    self:ScheduleTimer("DeathEventHandler", self.db.profile.events.death.timer + fixDelay)
                else
                    self:PrintDebug("Player died in the wrong area. No screenshot requested.")
                end
            else
                self:PrintDebug("Event 'PLAYER_DEAD' completed. No screenshot requested.")
            end
        end
    )

    self:PrintDebug("Event 'PLAYER_DEAD' registered.")

    self:RegisterEvent(
        "PLAYER_LOGIN",
        function()
            self:PrintDebug("Event 'PLAYER_LOGIN' fired. No payload.")

            if self.db.profile.events.login.active then
                TimePlayed()

                self:ScheduleTimer("LoginEventHandler", self.db.profile.events.login.timer + fixDelay)
            else
                self:PrintDebug("Event 'PLAYER_LOGIN' completed. No screenshot requested.")
            end
        end
    )

    self:PrintDebug("Event 'PLAYER_LOGIN' registered.")
    self:PrintDebug("Addon fully loaded.")
end
