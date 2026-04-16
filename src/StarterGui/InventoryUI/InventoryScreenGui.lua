-- In StarterGui, create a ScreenGui named "InventoryUI".
-- Inside:
--  - Main dark panel centered.
--  - Left: grid of weapon icons.
--  - Right: stats panel (damage, tier, description).
--  - Bottom: "Equip" button, "Craft" button, fragment count.
-- Style everything with dark backgrounds + neon borders.
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "InventoryUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Enabled = false
gui.Parent = PlayerGui

local main = Instance.new("Frame")
main.Name = "MainPanel"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.Size = UDim2.new(0, 700, 0, 400)
main.BackgroundColor3 = Color3.fromRGB(8, 8, 15)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0, 255, 170)
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = main

local glow = Instance.new("ImageLabel")
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://4996891970"
glow.ImageColor3 = Color3.fromRGB(0, 255, 170)
glow.Size = UDim2.new(1.4, 0, 1.4, 0)
glow.Position = UDim2.new(0.5, 0, 0.5, 0)
glow.AnchorPoint = Vector2.new(0.5, 0.5)
glow.ImageTransparency = 0.8
glow.ZIndex = 0
glow.Parent = main

-- Title
local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -20, 0, 40)
title.Position = UDim2.new(0, 10, 0, 10)
title.Text = "WEAPON INVENTORY"
title.TextColor3 = Color3.fromRGB(0, 255, 170)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

-- Left: weapon grid
local gridFrame = Instance.new("Frame")
gridFrame.Name = "WeaponGrid"
gridFrame.BackgroundTransparency = 1
gridFrame.Position = UDim2.new(0, 20, 0, 60)
gridFrame.Size = UDim2.new(0, 360, 1, -80)
gridFrame.Parent = main

local gridLayout = Instance.new("UIGridLayout")
gridLayout.CellSize = UDim2.new(0, 80, 0, 80)
gridLayout.CellPadding = UDim2.new(0, 8, 0, 8)
gridLayout.FillDirectionMaxCells = 3
gridLayout.Parent = gridFrame

-- Right: stats panel
local stats = Instance.new("Frame")
stats.Name = "StatsPanel"
stats.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
stats.BorderSizePixel = 0
stats.Position = UDim2.new(0, 400, 0, 60)
stats.Size = UDim2.new(0, 280, 1, -120)
stats.Parent = main

local statsCorner = Instance.new("UICorner")
statsCorner.CornerRadius = UDim.new(0, 12)
statsCorner.Parent = stats

local statsStroke = Instance.new("UIStroke")
statsStroke.Thickness = 2
statsStroke.Color = Color3.fromRGB(0, 200, 255)
statsStroke.Parent = stats

local statsTitle = Instance.new("TextLabel")
statsTitle.BackgroundTransparency = 1
statsTitle.Size = UDim2.new(1, -20, 0, 30)
statsTitle.Position = UDim2.new(0, 10, 0, 10)
statsTitle.Text = "WEAPON STATS"
statsTitle.TextColor3 = Color3.fromRGB(0, 255, 220)
statsTitle.Font = Enum.Font.GothamBold
statsTitle.TextSize = 20
statsTitle.TextXAlignment = Enum.TextXAlignment.Left
statsTitle.Parent = stats

local statsText = Instance.new("TextLabel")
statsText.Name = "StatsText"
statsText.BackgroundTransparency = 1
statsText.Size = UDim2.new(1, -20, 1, -60)
statsText.Position = UDim2.new(0, 10, 0, 40)
statsText.Text = "Select a weapon..."
statsText.TextColor3 = Color3.fromRGB(200, 255, 255)
statsText.Font = Enum.Font.Gotham
statsText.TextSize = 16
statsText.TextXAlignment = Enum.TextXAlignment.Left
statsText.TextYAlignment = Enum.TextYAlignment.Top
statsText.TextWrapped = true
statsText.Parent = stats

-- Bottom buttons
local bottomBar = Instance.new("Frame")
bottomBar.BackgroundTransparency = 1
bottomBar.Size = UDim2.new(1, -40, 0, 40)
bottomBar.Position = UDim2.new(0, 20, 1, -50)
bottomBar.Parent = main

local bottomLayout = Instance.new("UIListLayout")
bottomLayout.FillDirection = Enum.FillDirection.Horizontal
bottomLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
bottomLayout.Padding = UDim.new(0, 10)
bottomLayout.Parent = bottomBar

local function neonButton(parent, text)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(10, 20, 25)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 255, 170)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 10)
    c.Parent = btn

    local s = Instance.new("UIStroke")
    s.Thickness = 2
    s.Color = Color3.fromRGB(0, 255, 170)
    s.Parent = btn

    return btn
end

local craftBtn = neonButton(bottomBar, "CRAFT")
craftBtn.Name = "CraftButton"

local equipBtn = neonButton(bottomBar, "EQUIP")
equipBtn.Name = "EquipButton"

-- Fragment counter
local fragLabel = Instance.new("TextLabel")
fragLabel.Name = "FragmentLabel"
fragLabel.BackgroundTransparency = 1
fragLabel.Size = UDim2.new(0, 200, 0, 30)
fragLabel.Position = UDim2.new(0, 20, 1, -40)
fragLabel.Text = "Fragments: 0"
fragLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
fragLabel.Font = Enum.Font.GothamBold
fragLabel.TextSize = 18
fragLabel.TextXAlignment = Enum.TextXAlignment.Left
fragLabel.Parent = main

return gui
