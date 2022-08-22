-- https://github.com/lord-sugarv2/LordsLib/blob/main/LICENSE
local function sqlDelete(tableName)
    sql.Query("DROP TABLE "..tableName..";")
end
LordsLib.Functions["DeleteSQL"] = sqlDelete

local function sqlCreate(tableName, values, shouldDelete)
    if shouldDelete then
        sql.Query("DROP TABLE "..tableName..";")
    end
    sql.Query("CREATE TABLE IF NOT EXISTS "..tableName.." "..values)
end
LordsLib.Functions["CreateSQL"] = sqlCreate

local function sqlPrint(tblName)
    local data = sql.Query("SELECT * FROM "..tblName..";")
    PrintTable(data and data or {})
    return data and data or {}
end
LordsLib.Functions["PrintSQL"] = sqlPrint

local function sqlInsert(tblName, places, values2)
    sql.Query("INSERT INTO "..tblName.." "..places.." VALUES"..values2..";")
end
LordsLib.Functions["InsertSQL"] = sqlInsert

local function sqlremove(tblName, statement)
    sql.Query("DELETE FROM "..tblName.." WHERE "..statement..";")
end
LordsLib.Functions["RemoveSQL"] = sqlremove

local function sqlupdate(tblName, place, value, statement)
    if statement then
        sql.Query("UPDATE "..tblName.." SET "..place.." = "..value.." WHERE "..statement..";")
    else
        sql.Query("UPDATE "..tblName.." SET "..place.." = "..value..";")
    end
end
LordsLib.Functions["UpdateSQL"] = sqlupdate

local function sqltable(tblName, statement)
    if statement then
        local data = sql.Query("SELECT * FROM "..tblName.." WHERE "..statement..";")
        return data and data or false
    end

    local data = sql.Query("SELECT * FROM "..tblName..";")
    return data and data or false
end
LordsLib.Functions["GetSQL"] = sqltable