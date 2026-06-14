local addonName, MEM = ...

MEM.settings = MEM.settings or {}
MEM.data = MEM.data or {}
MEM.state = MEM.state or {}
MEM.modules = MEM.modules or {}

MEM.state.totalTimePlayed = 0
MEM.state.timePlayedThisLevel = 0

local AWL = ArcaneWizardLibrary

AWL:NewAddon(addonName, {
	debugEnabled = function()
		return MEM.settings.general and MEM.settings.general["debug-mode"]
	end
})
