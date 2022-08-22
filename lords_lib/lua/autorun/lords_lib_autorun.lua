LordsLib = LordsLib or {}
LordsLib.Functions = LordsLib.Functions or {}
LordsLib.Keys = LordsLib.Keys or {}

local function Server(str)
    if SERVER then
        include(str)
    end
end

local function Client(str)
    if SERVER then
        AddCSLuaFile(str)
    else
        include(str)
    end
end

local function Shared(str)
    Server(str)
    Client(str)
end

-- Dont change this order there is a chance u will break the addon
local base = "lords_lib/"
Shared(base.."sh.lua")
Shared(base.."modules/sh_loader.lua")
Shared(base.."functions/sh_functions.lua")
Client(base.."functions/cl_functions.lua")
Server(base.."functions/sv_functions.lua")
Server(base.."modules/sh_sql.lua")
Server(base.."modules/sh_sounds.lua")
Server(base.."modules/sv_players.lua")
Server(base.."modules/sh_keys.lua")
Server(base.."modules/sv_gamemode.lua")
Server(base.."modules/sh_math.lua")
Client(base.."modules/cl_imgur.lua")
Client(base.."modules/cl_font.lua")

Server(base.."modules/log/sv_log.lua")
Client(base.."modules/log/cl_log.lua")
Shared(base.."testing/sh_testing.lua")
Server(base.."testing/sv_testing.lua")
Client(base.."testing/cl_testing.lua")

Client(base.."vgui/cl_frame.lua")
Client(base.."vgui/cl_scroll.lua")
Client(base.."vgui/cl_textentry.lua")
hook.Run("LLib:FullyLoaded")