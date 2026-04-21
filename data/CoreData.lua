local addonName, MEM = ...

MEM.ADDON_AUTHOR = C_AddOns.GetAddOnMetadata(addonName, "Author")
MEM.ADDON_VERSION = C_AddOns.GetAddOnMetadata(addonName, "Version")
MEM.ADDON_BUILD_DATE = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate")

MEM.GAME_VERSION = GetBuildInfo()

MEM.LINK_GITHUB = C_AddOns.GetAddOnMetadata(addonName, "X-Github")
MEM.LINK_CURSEFORGE = C_AddOns.GetAddOnMetadata(addonName, "X-Curseforge")

MEM.MEDIA_PATH = "Interface\\AddOns\\" .. addonName .. "\\assets\\"

MEM.GAME_TYPE_VANILLA = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
MEM.GAME_TYPE_TBC = (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC)
---@diagnostic disable-next-line: undefined-global
MEM.GAME_TYPE_MISTS = (WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC)
MEM.GAME_TYPE_MAINLINE = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)

MEM.GAME_FLAVOR = "unknown"

if MEM.GAME_TYPE_VANILLA then
	MEM.GAME_FLAVOR = "Classic"
elseif MEM.GAME_TYPE_TBC then
	MEM.GAME_FLAVOR = "Burning Crusade - Classic Anniversary Edition"
elseif MEM.GAME_TYPE_MISTS then
	MEM.GAME_FLAVOR = "Mist of Pandaria - Classic"
elseif MEM.GAME_TYPE_MAINLINE then
	MEM.GAME_FLAVOR = "Retail"
end
