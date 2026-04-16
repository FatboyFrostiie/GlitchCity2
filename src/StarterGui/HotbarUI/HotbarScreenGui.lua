local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HotbarUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = PlayerGui

-- MAIN BAR
local bar = Instance.new("Frame")
bar.Name = "Hotbar"
bar.AnchorPoint = Vector2.new(0.5, 1)
bar.Position = UDim2.new(0.5, 0, 1, -20)
bar.Size = UDim2.new(0, 420, 0, 70)
bar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
bar.BorderSizePixel = 0
bar.Parent = screenGui

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0, 12)
barCorner.Parent = bar

-- NEON BORDER
local border = Instance.new("UIStroke")
border.Thickness = 2
border.Color = Color3.fromRGB(0, 255, 170)
border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
border.Parent = bar

-- GLOW
local glow = Instance.new("ImageLabel")
glow.Name = "Glow"
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://4996891970"
glow.ImageColor3 = Color3.fromRGB(0, 255, 170)
glow.Size = UDim2.new(1, 20, 1, 20)
glow.Position = UDim2.new(0.5, 0, 0.5, 0)
glow.AnchorPoint = Vector2.new(0.5, 0.5)
glow.ZIndex = 0
glow.ImageTransparency = 0.65
glow.Parent = bar

-- SLOT LAYOUT
local layout = Instance.new("UIListLayout")
layout.FillDirection = Enum.FillDirection.Horizontal
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Padding = UDim.new(0, 8)
layout.Parent = bar

-- FUNCTION TO CREATE A SLOT
local function createSlot(index)
    local slot = Instance.new("Frame")
    slot.Name = "Slot" .. index
    slot.Size = UDim2.new(0, 80, 0, 60)
    slot.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    slot.BorderSizePixel = 0
    slot.Parent = bar

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = slot

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(40, 40, 50)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = slot

    local label = Instance.new("TextLabel")
    label.Name = "Keybind"
    label.Size = UDim2.new(0, 20, 0, 20)
    label.Position = UDim2.new(0, 5, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = tostring(index)
    label.TextColor3 = Color3.fromRGB(0, 255, 170)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.Parent = slot

    local icon = Instance.new("ImageLabel")
    icon.Name = "Icon"
    icon.Size = UDim2.new(0, 40, 0, 40)
    icon.Position = UDim2.new(0.5, 0, 0.5, 0)
    icon.AnchorPoint = Vector2.new(0.5, 0.5)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://0" -- replace with weapon icons later
    icon.Parent = slot

    return slot
end

-- CREATE 4 SLOTS
for i = 1, 4 do
    createSlot(i)
end

return screenGui
