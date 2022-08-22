local PANEL = {}
AccessorFunc(PANEL, "m_Title", "Title")
AccessorFunc(PANEL, "m_Description", "Description")
AccessorFunc(PANEL, "m_Draggable", "Draggable", FORCE_BOOL)
AccessorFunc(PANEL, "m_Sizable", "Sizable", FORCE_BOOL)
AccessorFunc(PANEL, "m_MinWidth", "MinWidth", FORCE_NUMBER)
AccessorFunc(PANEL, "m_MinHeight", "MinHeight", FORCE_NUMBER)
AccessorFunc(PANEL, "m_ScreenLock", "ScreenLock", FORCE_BOOL)

function PANEL:Init()
    self:SetTitle("Your Addon")
    self:SetDescription("Customize your very epic addon description!")

    self.TopPanel = self:Add("DPanel")
    self.TopPanel:Dock(TOP)
    self.TopPanel.Paint = function(s, w, h)
        draw.RoundedBoxEx(6, 0, 0, w, h, LordsLib.Colors.TopPanel, true, true)
    end
    self.TopPanel.OnMousePressed = function()
        local screenX, screenY = self:LocalToScreen(0, 0)
        if (self.m_Sizable && gui.MouseX() > (screenX + self:GetWide() - 20) && gui.MouseY() > (screenY + self:GetTall() - 20)) then
            self.Sizing = {gui.MouseX() - self:GetWide(), gui.MouseY() - self:GetTall()}
            self:MouseCapture(true)
            return
        end

        if (self:GetDraggable() && gui.MouseY() < (screenY + 30)) then
            self.Dragging = {gui.MouseX() - self.x, gui.MouseY() - self.y}
            self:MouseCapture(true)
            return
        end
    end

    self.Tab = self.TopPanel:Add("DPanel")
    self.Tab:DockMargin(5, 5, 0, 0)
    self.Tab:Dock(LEFT)
    self.Tab.Paint = function(s, w, h)
        draw.RoundedBoxEx(6, 0, 0, w, h, LordsLib.Colors.Primary, true, true)
        draw.SimpleText(self:GetTitle() or "", "LLib:25", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    self.CloseButton = self.TopPanel:Add("DButton")
    self.CloseButton:Dock(RIGHT)
    self.CloseButton:SetText("✕")
    self.CloseButton:SetTextColor(color_white)
    self.CloseButton:SetFont("LLib:25")
    self.CloseButton.Alpha = 0
    self.CloseButton.Paint = function(s, w, h)
        if not s:IsHovered() then return end
        surface.SetDrawColor(LordsLib.Colors.Red)
        surface.DrawRect(0, 0, w, h)
    end
    self.CloseButton.DoClick = function()
        self:Remove()
    end

    self.Description = self:Add("DPanel")
    self.Description:Dock(TOP)
    self.Description.Paint = function(s, w, h)
        surface.SetDrawColor(LordsLib.Colors.Primary)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText(self:GetDescription() or "", "Trebuchet24", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    self.Settings = self.Description:Add("DButton")
    self.Settings:DockMargin(0, 5, 5, 5)
    self.Settings:Dock(RIGHT)
    self.Settings:SetText("Settings")
    self.Settings:SetTextColor(color_white)
    self.Settings.Paint = function(s, w, h)
        if not s:IsHovered() then return end
        surface.SetDrawColor(LordsLib.Colors.Secondary)
        surface.DrawRect(0, 0, w, h)
    end

    self:SetMinWidth(50)
	self:SetMinHeight(50)
	self:SetDraggable(true)
	self:SetSizable(false)
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(LordsLib.Colors.Background)
    surface.DrawRect(0, 30, w, h-30)
end

function PANEL:Think()
	local mousex = math.Clamp(gui.MouseX(), 1, ScrW() - 1)
	local mousey = math.Clamp(gui.MouseY(), 1, ScrH() - 1)

	if self.Dragging then
		local x = mousex - self.Dragging[1]
		local y = mousey - self.Dragging[2]
		if self:GetScreenLock() then
			x = math.Clamp(x, 0, ScrW() - self:GetWide())
			y = math.Clamp(y, 0, ScrH() - self:GetTall())
		end
		self:SetPos(x, y)
	end

	if self.Sizing then
		local x = mousex - self.Sizing[1]
		local y = mousey - self.Sizing[2]
		local px, py = self:GetPos()
		if x < self.m_MinWidth then x = self.m_MinWidth elseif (x > ScrW() - px && self:GetScreenLock()) then x = ScrW() - px end
		if y < self.m_MinHeight then y = self.m_MinHeight elseif (y > ScrH() - py && self:GetScreenLock()) then y = ScrH() - py end
		self:SetSize(x, y)
		self:SetCursor("sizenwse")
		return
	end

	local screenX, screenY = self:LocalToScreen(0, 0)
	if (self.Hovered && self.m_Sizable && mousex > (screenX + self:GetWide() - 20) && mousey > (screenY + self:GetTall() - 20)) then
		self:SetCursor("sizenwse")
		return
	end

	if (self.Hovered && self:GetDraggable() && mousey < (screenY + 24)) then
		self:SetCursor("sizeall")
		return
	end
	self:SetCursor("arrow")

	if (self.y < 0) then
		self:SetPos(self.x, 0)
	end
end

function PANEL:OnMousePressed()
    local screenX, screenY = self:LocalToScreen(0, 0)
    if (self.m_Sizable && gui.MouseX() > (screenX + self:GetWide() - 20) && gui.MouseY() > (screenY + self:GetTall() - 20)) then
        self.Sizing = {gui.MouseX() - self:GetWide(), gui.MouseY() - self:GetTall()}
        self:MouseCapture(true)
        return
    end

    if (self:GetDraggable() && gui.MouseY() < (screenY + 30)) then
        self.Dragging = {gui.MouseX() - self.x, gui.MouseY() - self.y}
        self:MouseCapture(true)
        return
    end
end

function PANEL:OnMouseReleased()
	self.Dragging = nil
	self.Sizing = nil
	self:MouseCapture(false)
end


function PANEL:PerformLayout()
    self.Settings:SetWide(50)
    self.Description:SetTall(30)
    self.TopPanel:SetTall(30)
    self.Tab:SetWide(240)
    self.CloseButton:SetWide(45)
end
vgui.Register("LFrame", PANEL, "EditablePanel")