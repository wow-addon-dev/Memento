local addonName, Memento = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

-----------------------
--- Local functions ---
-----------------------

local function SetupDatabase(self)
	if Memento.GAME_TYPE_MAINLINE then
		self.db = LibStub("AceDB-3.0"):New("Memento_Options", Memento.defaults["options-mainline"], true)
	elseif Memento.GAME_TYPE_MISTS then
		self.db = LibStub("AceDB-3.0"):New("Memento_Options", Memento.defaults["options-mists"], true)
	elseif Memento.GAME_TYPE_CATA then
		self.db = LibStub("AceDB-3.0"):New("Memento_Options", Memento.defaults["options-cata"], true)
	elseif Memento.GAME_TYPE_TBC then
		self.db = LibStub("AceDB-3.0"):New("Memento_Options", Memento.defaults["options-tbc"], true)
	elseif Memento.GAME_TYPE_VANILLA then
		self.db = LibStub("AceDB-3.0"):New("Memento_Options", Memento.defaults["options-vanilla"], true)
	end

	if (not Memento_DataBossKill) then
        Memento_DataBossKill = {}
    end
end

local function SetupOptions(self)
	local AceConfig = LibStub("AceConfigRegistry-3.0")
	local AceConfigDialog = LibStub("AceConfigDialog-3.0")

	local info = Memento.optionsTable["info"]

	local options = Memento.optionsTable["options"]

	if Memento.GAME_TYPE_MAINLINE then
		options.args.achievement =  Memento.optionsTable["eventAchievement-mainline"]
		options.args.encounter = Memento.optionsTable["eventEncounter-mainline"]
		options.args.pvp = Memento.optionsTable["eventPvP-mainline"]
	elseif Memento.GAME_TYPE_MISTS then
		options.args.achievement =  Memento.optionsTable["eventAchievement-mists"]
		options.args.encounter = Memento.optionsTable["eventEncounter-mists"]
		options.args.pvp = Memento.optionsTable["eventPvP-mists"]
	elseif Memento.GAME_TYPE_CATA then
		options.args.achievement =  Memento.optionsTable["eventAchievement-cata"]
		options.args.encounter = Memento.optionsTable["eventEncounter-cata"]
		options.args.pvp = Memento.optionsTable["eventPvP-cata"]
	elseif Memento.GAME_TYPE_TBC then
		options.args.encounter = Memento.optionsTable["eventEncounter-tbc"]
		options.args.pvp = Memento.optionsTable["eventPvP-tbc"]
	elseif Memento.GAME_TYPE_VANILLA then
		options.args.encounter = Memento.optionsTable["eventEncounter-vanilla"]
		options.args.pvp = Memento.optionsTable["eventPvP-vanilla"]
	end

	options.args.levelUp = Memento.optionsTable["eventLevelUp"]
	options.args.death = Memento.optionsTable["eventDeath"]
	options.args.login = Memento.optionsTable["eventLogin"]

	local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	profiles.confirm = true

	profiles.name = addonName .. " - " .. L["profiles"]

	AceConfig:RegisterOptionsTable(addonName, info)
	AceConfig:RegisterOptionsTable("Options", options)
    AceConfig:RegisterOptionsTable("Profiles", profiles)

	AceConfigDialog:AddToBlizOptions(addonName, addonName)
	AceConfigDialog:AddToBlizOptions("Options", L["options"], addonName)
    AceConfigDialog:AddToBlizOptions("Profiles", L["profiles"], addonName)
end

------------------------
--- Public functions ---
------------------------

function Memento:SetupAddon()
	SetupDatabase(self)
	SetupOptions(self)

	self:RegisterChatCommand("memento", "SlashCommand")

	self:PrintDebug("Default options and database have been loaded." )
end

function Memento:SlashCommand(msg)
	if not msg or msg:trim() == "" then
		--Settings.OpenToCategory(self.MAIN_CATEGORY_ID)
	else
        self:PrintDebug("No arguments will be accepted.")
	end
end
