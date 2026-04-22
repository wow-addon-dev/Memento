local addonName, MEM = ...

local L = MEM.Localization

local Utils = MEM.Utils

local Capture = {}

-----------------------
--- Local Functions ---
-----------------------

local function CreateMessageFrame()
    local frame = CreateFrame("Frame")
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
    frame.textTop:SetFont(tostring(frame.textTop:GetFont()), 7)
    frame.textTop:SetText(L["screen.message"])

    frame.textBottom = frame:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")
    frame.textBottom:ClearAllPoints()
    frame.textBottom:SetPoint("CENTER", 0, -6)
    frame.textBottom:SetFont(tostring(frame.textBottom:GetFont()), 7)
    frame.textBottom:SetText(tostring(date("%d/%m/%y %H:%M:%S", GetServerTime())))

    return frame
end

local function TakeScreenshot()
    if MEM.options.general["hide-ui"] then
        if not InCombatLockdown() then
            local frame

            local status, err = pcall(function ()
                UIParent:Hide()

                frame = CreateMessageFrame()
                frame:Show()

                C_Timer.After(0.1, function()
                    Screenshot()
                end)

                C_Timer.After(0.2, function()
                    UIParent:Show()
                    frame:Hide()
                end)

                Utils:PrintDebug("Screenshot without UI taken.")
            end)

            if not status then
                UIParent:Show()
                frame:Hide()

                Utils:PrintDebug("Method TakeScreenshot() (without UI) aborted with exception: " .. err)

                Screenshot()

                Utils:PrintDebug("Screenshot taken.")
            end
        else
            Utils:PrintDebug("No screenshot is possible in combat without ui.")
            Utils:PrintDebug("Screenshot taken.")
        end
    else
        Screenshot()

        Utils:PrintDebug("Screenshot taken.")
    end
end

local function LoginEventHandler()
    Utils:PrintMessage(L["chat.event.login.new"])
    TakeScreenshot()
end

local function IntervalEventHandler ()
    Utils:PrintMessage(L["chat.event.interval.new"])
    TakeScreenshot()
end

local HandlerTable = {
    ["IntervalEventHandler"] = IntervalEventHandler,
    ["LoginEventHandler"] = LoginEventHandler
}

---------------------
--- Main Funtions ---
---------------------

function Capture:ScheduleTimer(handler, delay)
	C_Timer.After(delay, function()
		if HandlerTable[handler] then
            HandlerTable[handler]()
        else
            Utils:PrintDebug("Handler '" .. tostring(handler) .. "' not found.")
        end
	end)
end

MEM.Capture = Capture
