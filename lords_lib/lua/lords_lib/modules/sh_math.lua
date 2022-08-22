-- https://github.com/lord-sugarv2/LordsLib/blob/main/LICENSE
local abcs = "abcdefghijklmnopqrstuvwxyz1234567890"
local function RandomGen(int)
    local str = ""
    for i = 1, int do
        str = str..abcs[math.random(1, #abcs)]
    end
    return str
end
LordsLib.Functions["GenerateString"] = RandomGen