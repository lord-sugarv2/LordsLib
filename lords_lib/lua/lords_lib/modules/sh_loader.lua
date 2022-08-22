local function AddServer(str)
    if SERVER then
        include(str)
    end
end
LordsLib.Functions["AddServer"] = AddServer

local function AddClient(str)
    if SERVER then
        AddCSLuaFile(str)
    else
        include(str)
    end
end
LordsLib.Functions["AddClient"] = AddClient

local function AddShared(str)
    Server(str)
    Client(str)
end
LordsLib.Functions["AddShared"] = AddShared

local function AddFile(File, dir)
    local fileSide = string.lower(string.Left(File, 3))
    if SERVER and fileSide == "sv_" then
        include(dir..File)
        print("[LLib Load] SV INCLUDE: "..File)
    elseif fileSide == "sh_" then
        if SERVER then 
            AddCSLuaFile(dir..File)
            print("[LLib Load] SH ADDCS: "..File)
        end
        include(dir..File)
        print("[LLib Load] SH INCLUDE: "..File)
    elseif fileSide == "cl_" then
        if SERVER then 
            AddCSLuaFile(dir..File)
            print("[LLib Load] CL ADDCS: "..File)
        elseif CLIENT then
            include(dir..File)
            print("[LLib Load] CL INCLUDE: "..File)
        end
    end
end

local function IncludeDir(dir)
    dir = dir.."/"
    local File, Directory = file.Find(dir.."*", "LUA")
    for k, v in ipairs(File) do
        if string.EndsWith(v, ".lua") then
            AddFile(v, dir)
        end
    end
    
    for k, v in ipairs(Directory) do
        print("[LLib Load] Directory: "..v)
        IncludeDir(dir..v)
    end
end
LordsLib.Functions["LoadFullDirectory"] = IncludeDir