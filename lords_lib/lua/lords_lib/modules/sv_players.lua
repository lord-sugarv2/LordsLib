-- https://github.com/lord-sugarv2/LordsLib/blob/main/LICENSE
local function KillAllPlayers(silent)
    for k, ply in ipairs(player.GetAll()) do
        if silent then
            ply:KillSilent()
            continue
        end
        ply:Kill()
    end
end
LordsLib.Functions["KillAllPlayers"] = KillAllPlayers

local function AddHP(ply, amount)
    ply:SetHealth(ply:Health() + amount)
end
LordsLib.Functions["AddHP"] = AddHP

local function RemoveHP(ply, amount, status)
    ply:SetHealth(ply:Health() - amount)

    if not status then return end
    if ply:Health() <= 0 then ply:Kill() end
end
LordsLib.Functions["RemoveHP"] = RemoveHP