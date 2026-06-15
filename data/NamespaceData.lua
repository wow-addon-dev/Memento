local addonName, MEM = ...

MEM.Settings = MEM.Settings or {}
MEM.Data = MEM.Data or {}
MEM.State = MEM.State or {}
MEM.Modules = MEM.Modules or {}

MEM.State.totalTimePlayed = 0
MEM.State.timePlayedThisLevel = 0

local AWL = ArcaneWizardLibrary

AWL:NewAddon(addonName, {
	debugEnabled = function()
		return MEM.Settings.general and MEM.Settings.general["debug-mode"]
	end
})
