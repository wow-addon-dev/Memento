local lib = LibStub:NewLibrary("Memento_PopupDialog-1.0", 1)

if not lib then
	return
end

local externalLink = ""

StaticPopupDialogs.EXTERNAL_LINK = {
	text = "%s",
	button1 = CLOSE,
	hasEditBox = true,
	editBoxWidth = 300,
	timeout = 0,
	whileDead = true,
	OnShow = function(self)
		self.EditBox:SetText(externalLink)
		self.EditBox:HighlightText()
	end,
	EditBoxOnTextChanged = function(self)
		self:SetText(externalLink)
		self:HighlightText();
	end
}

function lib.ShowDialogExternalLink(link, text)
    externalLink = link

    StaticPopup_Show("EXTERNAL_LINK", text)
end
