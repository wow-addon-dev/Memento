local addonName, MEM = ...

local L = MEM.Localization

local Utils = MEM.Utils

-----------------------
--- Global Funtions ---
-----------------------

function Memento_CompartmentOnEnter(self, button)
	GameTooltip:ClearAllPoints()
	GameTooltip:SetOwner(button, "ANCHOR_LEFT")

	GameTooltip_SetTitle(GameTooltip, addonName)
	GameTooltip_AddNormalLine(GameTooltip, MEM.ADDON_VERSION .. " (" .. MEM.ADDON_BUILD_DATE .. ")")
	GameTooltip_AddBlankLineToTooltip(GameTooltip)
	GameTooltip_AddHighlightLine(GameTooltip, L["minimap-button.tooltip"])

	GameTooltip:Show()
end

function Memento_CompartmentOnLeave()
    GameTooltip:Hide()
end

function Memento_CompartmentOnClick(_, button)
    if button == "RightButton" then
		if not InCombatLockdown() then
			Settings.OpenToCategory(MEM.MAIN_CATEGORY_ID)
		else
			Utils:PrintDebug("In combat. The options menu cannot be opened.")
		end
    end
end
