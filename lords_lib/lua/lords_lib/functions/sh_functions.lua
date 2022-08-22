function LordsLib:RemoveID(tbl, id)
    if not tbl or not id then return end

    for k, v in ipairs(tbl) do
        if v[1] ~= id then continue end
        table.remove(tbl, k)
    end
end

function LordsLib:GetFunctions()
    return LordsLib.Functions
end