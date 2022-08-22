-- To start put local LLib = LordsLib:GetFunctions() top of your file

-- When you press key it runs function
LLib.OnKeyPressed(id, key, func)
LLib.OnKeyPressed("UniqueID", KEY_K, function(player)
end)

-- When you release key it runs function
LLib.OnKeyReleased(id, key, func)
LLib.OnKeyReleased("UniqueID", KEY_K, function(player)
end)

-- When the button is up it runs function
LLib.OnButtonUP(id, key, func)
LLib.OnButtonUP("UniqueID", KEY_K, function(player)
end)

-- When the button is down it runs function
LLib.OnButtonDown(id, key, func)
LLib.OnButtonDown("UniqueID", KEY_K, function(player)
end)

LLib.KillAllPlayers(false) -- false: kill normally, true: kill silently
LLib.AddHP(player, amount) -- adds health to player
LLib.RemoveHP(player, amount, false) -- removes hp: true to make it not kill the player if they go below 0 hp
LLib.PlaySound(position, sound) -- plays a sound at the position
LLib.EmitSound(ent, soundstr) -- makes an entity emit a sound

LLib.OnStartup(id, func) -- called when the server startsup

LLib.PrintSQL(tblName)
LLib.CreateSQL(tblName, valuesStr, shouldDelete)
LLib.DeleteSQL(tblName)
LLib.InsertSQL(tblName, places, values2)
LLib.RemoveSQL(tblName, statement)
LLib.UpdateSQL(tblName, place, value, statement)
LLib.GetSQL(tblName, statement)

LLib.AddLog(id, message, important)
LLib.GetLogTabs()
LLib.GetLogData(tab)

LLib.GenerateString(int)

LLib.AddServer(file)
LLib.AddClient(file)
LLib.AddShared(file)
LLib.LoadFullDirectory(dir)