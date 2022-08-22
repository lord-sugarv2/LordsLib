-- https://github.com/lord-sugarv2/LordsLib/blob/main/LICENSE
function LordsLib:CreateFont(name, size)
	local tbl = {
		font = "Montserrat Medium",
		size = size,
		extended = true
	}

	surface.CreateFont(name, tbl)
end
LordsLib:CreateFont("LLib:15", 15)
LordsLib:CreateFont("LLib:20", 20)
LordsLib:CreateFont("LLib:25", 25)