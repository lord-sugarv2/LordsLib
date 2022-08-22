LordsLib.Log = LordsLib.Log or {}
LordsLib.Log.Tabs = LordsLib.Log.Tabs or {}
LordsLib.Log.TabData = LordsLib.Log.TabData or {}

local one, two = Color(25, 25, 25), Color(40, 40, 40)
local function LogMenu()
    if IsValid(LordsLib.Log.Menu) then LordsLib.Log.Menu:Remove() end
    LordsLib.Log.Menu = vgui.Create("LFrame")
    local frame = LordsLib.Log.Menu
    frame:SetSize(600, 400)
    frame:Center()
    frame:MakePopup()
    frame:SetTitle("")
    frame:SetTitle("LordsLib Log")
    frame:SetDescription("")
    frame.Paint = function(s, w, h)
        draw.RoundedBox(6, 0, 0, w, h, one)
    end

    local scroll = frame:Add("LScrollPanel")
    scroll:DockMargin(0, 5, 5, 0)
    scroll:Dock(FILL)

    if not LordsLib.Log.Tabs or #LordsLib.Log.Tabs < 1 then return end
    for k, v in ipairs(LordsLib.Log.Tabs) do
        local panel = scroll:Add("DButton")
        panel:DockMargin(5, 0, 5, 5)
        panel:Dock(TOP)
        panel:SetTall(75)
        panel:SetText("")
        panel.Paint = function(s, w, h)
            draw.RoundedBox(6, 0, 0, w, h, two)
            draw.SimpleText(v, "DermaLarge", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        panel.DoClick = function(s)
            net.Start("LordsLib:AskForTab")
            net.WriteString(v)
            net.SendToServer()
        end
    end
end

local function createpanel(scroll, v)
    local panel = scroll:Add("DPanel")
    panel:DockMargin(5, 0, 5, 5)
    panel:Dock(TOP)
    panel:SetTall(75)
    panel.Paint = function(s, w, h)
        draw.RoundedBox(6, 0, 0, w, h, two)
        local w2, h2 = draw.SimpleText(v.Time, "Trebuchet24", 5, 5, color_white)
        local w3, h3 = draw.SimpleText(v.Message, "Trebuchet18", 5, h2+5, color_white)
        draw.SimpleText("Important: "..tostring(v.Important), "Trebuchet18", 5, h3+32, color_white)
    end
    panel.DoClick = function(s)
        net.Start("LordsLib:AskForTab")
        net.WriteString(v)
        net.SendToServer()
    end
    return panel
end

local function OpenTab()
    if IsValid(LordsLib.Log.Menu) then LordsLib.Log.Menu:Remove() end
    LordsLib.Log.Menu = vgui.Create("DFrame")
    local frame = LordsLib.Log.Menu
    frame:DockPadding(0, 25, 0, 0)
    frame:SetSize(600, 400)
    frame:Center()
    frame:MakePopup()
    frame:SetTitle("")
    frame.Paint = function(s, w, h)
        draw.RoundedBox(6, 0, 0, w, h, one)
    end

    local tbl = {}
    local scroll = frame:Add("DScrollPanel")
    scroll:Dock(FILL)

    local checkbox = scroll:Add("DCheckBoxLabel")
    checkbox:Dock(TOP)
    checkbox:SetTall(50)
    checkbox:SetText("Important")
    checkbox.OnChange = function(s, val)
        for k, v in ipairs(tbl) do
            v:Remove()
        end

        if not LordsLib.Log.TabData or #LordsLib.Log.TabData < 1 then return end
        for k, v in ipairs(LordsLib.Log.TabData) do
            if not val then
                local panel = createpanel(scroll, v)
                table.insert(tbl, panel)
                continue
            end

            if not v.Important then continue end
            local panel = createpanel(scroll, v)
            table.insert(tbl, panel)
        end
    end

    if not LordsLib.Log.TabData or #LordsLib.Log.TabData < 1 then return end
    for k, v in ipairs(LordsLib.Log.TabData) do
        local panel = createpanel(scroll, v)
        table.insert(tbl, panel)
    end
end

net.Receive("LordsLib:NetworkTabs", function()
    local int = net.ReadUInt(32)

    LordsLib.Log.Tabs = {}
    for i = 1, int do
        table.insert(LordsLib.Log.Tabs, net.ReadString())
    end
    LogMenu()
end)

net.Receive("LordsLib:NetworkTabData", function()
    local tabname, int = net.ReadString(), net.ReadUInt(32)

    LordsLib.Log.TabData = {}
    for i = 1, int do
        local message, time, important = net.ReadString(), net.ReadString(), net.ReadBool()
        local tbl = {
            Message = message,
            Time = time,
            Important = important,
        }
        table.insert(LordsLib.Log.TabData, tbl)
    end
    OpenTab()
end)