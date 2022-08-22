util.AddNetworkString("LordsLib:ChatMessage")
function LordsLib:ChatMessage(ply, str)
    net.Start("LordsLib:ChatMessage")
    net.WriteString(str)
    net.Send(ply)
end