-- https://github.com/lord-sugarv2/LordsLib/blob/main/LICENSE
net.Receive("LordsLib:ChatMessage", function()
    local str = net.ReadString()
    chat.AddText(str)
end)