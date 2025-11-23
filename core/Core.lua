local addonName, Memento = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

----------------------
--- Local funtions ---
----------------------

local function createMessageFrame(frame)
    local font

    frame = CreateFrame("Frame")
    frame:ClearAllPoints()
    frame:SetPoint("BOTTOM", 0, 100)
    frame:SetSize(164, 41)

    frame.background = frame:CreateTexture(nil, "BACKGROUND")
    frame.background:ClearAllPoints()
    frame.background:SetAllPoints(frame)
    frame.background:SetTexture(612384)

    frame.textTop = frame:CreateFontString(nil, "OVERLAY", "GameFontBlackTiny")
    frame.textTop:ClearAllPoints()
    frame.textTop:SetPoint("CENTER", 0, 5)
    font = frame.textTop:GetFont()
    frame.textTop:SetFont(tostring(font), 7)
    frame.textTop:SetText(L["screen.message"])

    frame.textBottom = frame:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")
    frame.textBottom:ClearAllPoints()
    frame.textBottom:SetPoint("CENTER", 0, -6)
    font = frame.textBottom:GetFont()
    frame.textBottom:SetFont(tostring(font), 7)
    frame.textBottom:SetText(tostring(date("%d/%m/%y %H:%M:%S", GetServerTime())))

    return frame
end

-----------------------
--- Public funtions ---
-----------------------

function Memento:TakeScreenshot(event)
    if self.db.profile.options.ui then
        if not InCombatLockdown() then
            local frame = CreateFrame("Frame")

            local status, err = pcall(function ()
                UIParent:Hide()

                frame = createMessageFrame(frame)
                frame:Show()

                C_Timer.After(0.1, function()
                    Screenshot()
                end)

                C_Timer.After(0.2, function()
                    UIParent:Show()
                    frame:Hide()
                end)

                self:PrintDebug("Screenshot without UI taken.")
            end)

            if not status then
                UIParent:Show()
                frame:Hide()

                self:PrintDebug("Method TakeScreenshot() (without UI) aborted with exception: " .. err)

                Screenshot()

                self:PrintDebug("Screenshot taken.")
            end
        else
            self:PrintDebug("No screenshot is possible in combat without ui.")
            self:PrintDebug("Screenshot taken.")
        end
    else
        Screenshot()

        self:PrintDebug("Screenshot taken.")
    end
end
