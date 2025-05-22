local addonName, Memento = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

-----------------------
--- Color functions ---
-----------------------

function Memento_MarkNormalFont(text)
	return WrapTextInColorCode(text, Memento.COLOR_NORMAL_FONT)
end

function Memento_MarkWhiteFont(text)
	return WrapTextInColorCode(text, Memento.COLOR_WHITE_FONT)
end

function Memento_MarkOrangeFont(text)
	return WrapTextInColorCode(text, Memento.COLOR_ORANGE_FONT)
end

function Memento_MarkGoldFont(text)
	return WrapTextInColorCode(text, Memento.COLOR_GOLD_FONT)
end

----------------------
--- Link functions ---
----------------------

function Memento_GetLevelUpLink(level)
    return "|cffFF4E00|Hlevelup:" .. level .. ":LEVEL_UP_TYPE_CHARACTER|h[" .. L["chat.level.name"] .. " " .. level .. "]|h|r"
end

-----------------------
--- Style functions ---
-----------------------

function Memento_GetStyleLineSmall(order)
	local table = {
		name = "",
		type = "description",
		width = "full",
		fontSize = "medium",
		order = order
	}

	return table
end

function Memento_GetStyleLineNormal(order)
	local table = {
		name = " ",
		type = "description",
		width = "full",
		fontSize = "medium",
		order = order
	}

	return table
end

function Memento_GetStyleSeparator(order)
	local table = {
		name = "",
		type = "header",
		dialogControl = "SFX-Header",
		order = order
	}

	return table
end

function Memento_GetStyleSeparatorText(order, name)
	local table = {
		name = name,
		type = "header",
		dialogControl = "SFX-Header-II",
		order = order
	}

	return table
end
