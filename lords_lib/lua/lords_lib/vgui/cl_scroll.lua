-- https://github.com/lord-sugarv2/LordsLib/blob/main/LICENSE
local PANEL = {}
function PANEL:Init()
    self.VBar:SetWide(12)
    self.VBar:SetHideButtons(true)

    self.VBar.Paint = function(pnl, w, h) end

    self.VBar.btnGrip.Paint = function(pnl, w, h)
        if pnl:IsHovered() then
            draw.RoundedBox(6, 0, 0, w, h, Color(170, 170, 170))
        else
            draw.RoundedBox(6, 0, 0, w, h, Color(200, 200, 200))
        end
    end
end

function PANEL:HideScrollBar(hide)
	self.VBar:SetWide((hide and 0) or 12)
end

vgui.Register("LScrollPanel", PANEL, "DScrollPanel")