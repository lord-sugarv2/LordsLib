local function PlaySound(pos, soundstr)
    sound.Play(soundstr, pos)
end
LordsLib.Functions["PlaySound"] = PlaySound

local function EmitSound(ent, soundstr)
    ent:EmitSound(soundstr)
end
LordsLib.Functions["EmitSound"] = EmitSound