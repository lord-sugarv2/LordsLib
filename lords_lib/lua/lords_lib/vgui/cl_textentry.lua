local PANEL = {}
function PANEL:Init()
    self.TextEntry = vgui.Create("PIXEL.TextEntryInternal", self)
    self.TextEntry:DockMargin(5, 5, 5, 5)
    self.TextEntry:Dock(FILL)
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(LordsLib.Colors.Darker)
    surface.DrawRect(0, 0, w, h)

    surface.SetDrawColor(LordsLib.Colors.Grey)
    surface.DrawOutlinedRect(0, 0, w, h, 1)

    if self:GetValue() == "" then
        draw.SimpleText(self:GetPlaceholderText() or "", "LLib:15", 5, h / 2, self.PlaceholderTextCol, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
end

function PANEL:OnChange() end
function PANEL:OnValueChange(value) end

function PANEL:IsEnabled() return self.TextEntry:IsEnabled() end
function PANEL:SetEnabled(bool) self.TextEntry:SetEnabled(bool) end

function PANEL:GetValue() return self.TextEntry:GetValue() end
function PANEL:SetValue(value) self.TextEntry:SetValue(value) end

function PANEL:IsMultiline() return self.TextEntry:IsMultiline() end
function PANEL:SetMultiline(multiline) self.TextEntry:SetMultiline(multiline) end

function PANEL:IsEditing() return self.TextEntry:IsEditing() end
function PANEL:GetEnterAllowed() return self.TextEntry:GetEnterAllowed() end
function PANEL:SetEnterAllowed(bool) self.TextEntry:SetEnterAllowed(bool) end

function PANEL:GetUpdateOnType() return self.TextEntry:GetUpdateOnType() end
function PANEL:SetUpdateOnType(bool) self.TextEntry:SetUpdateOnType(bool) end

function PANEL:GetNumeric() return self.TextEntry:GetNumeric() end
function PANEL:SetNumeric(bool) self.TextEntry:SetNumeric(bool) end

function PANEL:GetHistoryEnabled() return self.TextEntry:GetHistoryEnabled() end
function PANEL:SetHistoryEnabled(bool) self.TextEntry:SetHistoryEnabled(bool) end

function PANEL:GetTabbingDisabled() return self.TextEntry:GetTabbingDisabled() end
function PANEL:SetTabbingDisabled(bool) self.TextEntry:SetTabbingDisabled(bool) end

function PANEL:GetPlaceholderText() return self.TextEntry:GetPlaceholderText() end
function PANEL:SetPlaceholderText(text) self.TextEntry:SetPlaceholderText(text) end

function PANEL:GetInt() return self.TextEntry:GetInt() end
function PANEL:GetFloat() return self.TextEntry:GetFloat() end

function PANEL:IsEditing() return self.TextEntry:IsEditing() end
function PANEL:SetEditable(bool) self.TextEntry:SetEditable(bool) end

function PANEL:AllowInput(value) end
function PANEL:GetAutoComplete(text) end

function PANEL:OnKeyCode(key) end
function PANEL:OnEnter() end

function PANEL:OnGetFocus() end
function PANEL:OnLoseFocus() end

vgui.Register("LTextEntry", PANEL, "Panel")