local addonName, MEM = ...

local version = C_AddOns.GetAddOnMetadata(addonName, "Version") or ""
local buildDate = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate") or ""
local currentVersion = version

if buildDate ~= "" then
	currentVersion = currentVersion .. " (" .. buildDate .. ")"
end

MEM.CHANGELOG_TEXT = table.concat({
	"|cffffd200" .. currentVersion .. "|r\n\n"
		.. "- Added: Changelog window available from the options menu\n"
		.. "- Removed: Version notice chat messages\n"
		.. "- Adapted to the latest version of Arcane Wizard: Library to ensure full compatibility",
	"|cffffd200v2.23 (2026-08-14)|r\n\n"
		.. "- Removed: TOC version for patch 12.0.7 [retail]",
	"|cffffd200v2.22 (2026-08-04)|r\n\n"
		.. "- Minor code adjustments",
	"|cffffd200v2.21 (2026-07-31)|r\n\n"
		.. "- Changed: Playtime data is now requested only when at least one playtime output is enabled\n"
		.. "- Updated: deDE, enUS localizations\n"
		.. "- Minor code adjustments",
	"|cffffd200v2.20 (2026-07-28)|r\n\n"
		.. "- Added: TOC version for patch 1.15.9 [classic]\n"
		.. "- Added: New event 'Special Loot' - A screenshot can now be taken automatically when selected types of special loot are received\n"
		.. "- Removed: TOC version for patch 1.15.8 [classic]\n"
		.. "- Minor code adjustments\n"
		.. "- Adapted to the latest version of Arcane Wizard: Library to ensure full compatibility"
}, "\n\n")
