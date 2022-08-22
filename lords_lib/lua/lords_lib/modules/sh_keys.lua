-- https://github.com/lord-sugarv2/LordsLib/blob/main/LICENSE
LordsLib.Keys["OnKeyPressed"] = LordsLib.Keys["OnKeyPressed"] or {}
LordsLib.Keys["OnKeyReleased"] = LordsLib.Keys["OnKeyReleased"] or {}
LordsLib.Keys["OnButtonUP"] = LordsLib.Keys["OnButtonUP"] or {}
LordsLib.Keys["OnButtonDown"] = LordsLib.Keys["OnButtonDown"] or {}

local function KeyPressed(id, key, func)
    LordsLib:RemoveID(LordsLib.Keys["OnKeyPressed"], id)
    table.Add(LordsLib.Keys["OnKeyPressed"], {{id, key, func}})
end
hook.Add("PlayerButtonDown", "LordsLib:KeyPress", function(ply, button)
    if not IsFirstTimePredicted() then
        for k, v in ipairs(LordsLib.Keys["OnButtonDown"]) do
            if v[2] ~= button then continue end
            v[3](ply)
        end
        return
    end

    for k, v in ipairs(LordsLib.Keys["OnKeyPressed"]) do
        if v[2] ~= button then continue end
        v[3](ply)
    end
end)
LordsLib.Functions["OnKeyPressed"] = KeyPressed

local function KeyReleased(id, key, func)
    LordsLib:RemoveID(LordsLib.Keys["OnKeyReleased"], id)
    table.Add(LordsLib.Keys["OnKeyReleased"], {{id, key, func}})
end
hook.Add("PlayerButtonUp", "LordsLib:KeyReleased", function(ply, button)
    if not IsFirstTimePredicted() then return end

    for k, v in ipairs(LordsLib.Keys["OnKeyReleased"]) do
        if v[2] ~= button then continue end
        v[3](ply)
    end
end)
LordsLib.Functions["OnKeyReleased"] = KeyReleased