-- https://github.com/lord-sugarv2/LordsLib/blob/main/LICENSE
LordsLib.Keys["OnStartup"] = LordsLib.Keys["OnStartup"] or {}

local function OnStartup(id, func)
    LordsLib:RemoveID(LordsLib.Keys["OnStartup"], id)
    table.Add(LordsLib.Keys["OnStartup"], {{id, func}})
end
hook.Add("Initialize", "LordsLib:OnStartup", function()
    for k, v in ipairs(LordsLib.Keys["OnStartup"]) do
        v[2]()
    end
end)
LordsLib.Functions["OnStartup"] = OnStartup