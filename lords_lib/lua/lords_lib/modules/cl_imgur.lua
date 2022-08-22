-- https://github.com/lord-sugarv2/LordsLib/blob/main/LICENSE
local fetching = {}
LordsLib.Imgur = LordsLib.Imgur or {}

file.CreateDir("lordslib")
function LordsLib:FetchImgur(id, func)
    if LordsLib.Imgur[id] then return func(LordsLib.Imgur[id]) end
    if fetching[id] then return end

    if file.Exists("lordslib/"..id..".png", "DATA") then
        LordsLib.Imgur[id] = "../data/lordslib/"..id..".png"
        return func(LordsLib.Imgur[id])
    end
    fetching[id] = true

    http.Fetch("https://i.imgur.com/"..id..".png",
        function(body, len, headers, code)
            file.Write("lordslib/"..id..".png", body)
            LordsLib.Imgur[id] = "../data/lordslib/" .. id .. ".png"

            fetching[id] = false
            return func(LordsLib.Imgur[id])
        end,
        function(error)
            fetching[id] = false
        end
    )
end

function LordsLib:GetImgur(id, func)
	func = func or function() end
	local str = LordsLib:FetchImgur(id, function(str)
		return func(str)
	end)
end