local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "AbilitySelectionUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Enabled = false
gui.Parent = PlayerGui

local panel = Instance.new("Frame")
panel.Name = "AbilityPanel"
panel.AnchorPoint = Vector2.new(0.5, 0.5)
panel.Position = UDim2.new(0.5, 0, 0.5, 0)
panel.Size = UDim2.new(0, 720, 0, 420)
panel.BackgroundColor3 = Color3.fromRGB(6, 6, 12)
panel.BorderSizePixel = 0
panel.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = panel

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0, 200, 255)
stroke.Parent = panel

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -20, 0, 40)
title.Position = UDim2.new(0, 10, 0, 10)
title.Text = "ABILITY LOADOUT"
title.TextColor3 = Color3.fromRGB(0, 255, 220)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = panel

-- XP bar
local xpBar = Instance.new("Frame")
xpBar.Name = "XPBar"
xpBar.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
xpBar.BorderSizePixel = 0
xpBar.Size = UDim2.new(1, -40, 0, 16)
xpBar.Position = UDim2.new(0, 20, 0, 60)
xpBar.Parent = panel

local xpCorner = Instance.new("UICorner")
xpCorner.CornerRadius = UDim.new(0, 8)
xpCorner.Parent = xpBar

local xpFill = Instance.new("Frame")
xpFill.Name = "Fill"
xpFill.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
xpFill.BorderSizePixel = 0
xpFill.Size = UDim2.new(0.3, 0, 1, 0)
xpFill.Parent = xpBar

local xpFillCorner = Instance.new("UICorner")
xpFillCorner.CornerRadius = UDim.new(0, 8)
xpFillCorner.Parent = xpFill

local xpLabel = Instance.new("TextLabel")
xpLabel.BackgroundTransparency = 1
xpLabel.Size = UDim2.new(1, 0, 1, 0)
xpLabel.Text = "XP: 0 / 0"
xpLabel.TextColor3 = Color3.fromRGB(200, 255, 255)
xpLabel.Font = Enum.Font.Gotham
xpLabel.TextSize = 14
xpLabel.Parent = xpBar

-- Left: ability list
local listFrame = Instance.new("Frame")
listFrame.Name = "AbilityList"
listFrame.BackgroundTransparency = 1
listFrame.Position = UDim2.new(0, 20, 0, 90)
listFrame.Size = UDim2.new(0, 320, 1, -120)
listFrame.Parent = panel

local listLayout = Instance.new("UIListLayout")
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.Padding = UDim.new(0, 6)
listLayout.Parent = listFrame

-- Right: equipped slots
local slotsFrame = Instance.new("Frame")
slotsFrame.Name = "EquippedSlots"
slotsFrame.BackgroundTransparency = 1
slotsFrame.Position = UDim2.new(0, 380, 0, 90)
slotsFrame.Size = UDim2.new(0, 320, 1, -120)
slotsFrame.Parent = panel

local slotsTitle = Instance.new("TextLabel")
slotsTitle.BackgroundTransparency = 1
slotsTitle.Size = UDim2.new(1, 0, 0, 30)
slotsTitle.Text = "EQUIPPED SLOTS"
slotsTitle.TextColor3 = Color3.fromRGB(0, 255, 220)
slotsTitle.Font = Enum.Font.GothamBold
slotsTitle.TextSize = 20
slotsTitle.Parent = slotsFrame

local slotsLayout = Instance.new("UIListLayout")
slotsLayout.FillDirection = Enum.FillDirection.Vertical
slotsLayout.Padding = UDim.new(0, 8)
slotsLayout.Parent = slotsFrame

local function slotRow(labelText)
    local row = Instance.new("Frame")
    row.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
    row.BorderSizePixel = 0
    row.Size = UDim2.new(1, 0, 0, 50)
    row.Parent = slotsFrame

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 10)
    c.Parent = row

    local keyLabel = Instance.new("TextLabel")
    keyLabel.BackgroundTransparency = 1
    keyLabel.Size = UDim2.new(0, 60, 1, 0)
    keyLabel.Position = UDim2.new(0, 10, 0, 0)
    keyLabel.Text = labelText
    keyLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
    keyLabel.Font = Enum.Font.GothamBold
    keyLabel.TextSize = 18
    keyLabel.TextXAlignment = Enum.TextXAlignment.Left
    keyLabel.Parent = row

    local abilityLabel = Instance.new("TextLabel")
    abilityLabel.Name = "AbilityName"
    abilityLabel.BackgroundTransparency = 1
    abilityLabel.Size = UDim2.new(1, -80, 1, 0)
    abilityLabel.Position = UDim2.new(0, 80, 0, 0)
    abilityLabel.Text = "Empty"
    abilityLabel.TextColor3 = Color3.fromRGB(200, 255, 255)
    abilityLabel.Font = Enum.Font.Gotham
    abilityLabel.TextSize = 16
    abilityLabel.TextXAlignment = Enum.TextXAlignment.Left
    abilityLabel.Parent = row

    return row
end

slotRow("Q")
slotRow("E")
slotRow("R")
slotRow("F")

return gui
