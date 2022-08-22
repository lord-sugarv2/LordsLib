local LLib = LordsLib:GetFunctions()
LLib.CreateSQL("LLibLog", "(addonid TEXT, message TEXT, time TEXT, important BOOL)")

local function AddToLog(id, message, important)
    local date = os.date("%x - %X")
    LLib.InsertSQL("LLibLog", "(addonid, message, time, important)", "("..sql.SQLStr(id)..", "..sql.SQLStr(message)..", "..sql.SQLStr(date)..", "..tostring(important)..")")
    print("LLib Log:", id, message, date, important)
end
LordsLib.Functions["AddLog"] = AddToLog

local function GetLobTabs()
    local data = LLib.GetSQL("LLibLog")
    if not data or #data <= 0 then return {} end

    local tbl = {}
    for k, v in ipairs(data) do
        tbl[v.addonid] = true
    end

    local tbl2 = {}
    for k, v in pairs(tbl) do
        table.insert(tbl2, k)
    end

    return tbl2
end
LordsLib.Functions["GetLogTabs"] = GetLobTabs

local function TabData(tab)
    local data = LLib.GetSQL("LLibLog", "addonid = "..sql.SQLStr(tab))
    if not data or #data <= 0 then return {} end

    return data
end
LordsLib.Functions["GetLogData"] = TabData

util.AddNetworkString("LordsLib:NetworkTabs")
hook.Add("PlayerSay", "LordsLib:NetworkLog", function(ply, text)
    if string.lower(text) == "!lordslib" then
        local tab = GetLobTabs()
        net.Start("LordsLib:NetworkTabs")
        net.WriteUInt(#tab, 32)
        for k, v in ipairs(tab) do
            net.WriteString(v)
        end
        net.Send(ply)
    end
end)

util.AddNetworkString("LordsLib:NetworkTabData")
util.AddNetworkString("LordsLib:AskForTab")
net.Receive("LordsLib:AskForTab", function(len, ply)
    local tabname = net.ReadString()
    local data = TabData(tabname)
    net.Start("LordsLib:NetworkTabData")
    net.WriteString(tabname)
    net.WriteUInt(#data, 32)
    for k, v in ipairs(data) do
        net.WriteString(v.message)
        net.WriteString(v.time)
        net.WriteBool(tobool(v.important))
    end
    net.Send(ply)
end)