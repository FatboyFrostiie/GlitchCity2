local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "CraftingUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Enabled = false
gui.Parent = PlayerGui

local panel = Instance.new("Frame")
panel.Name = "CraftPanel"
panel.AnchorPoint = Vector2.new(0.5, 0.5)
panel.Position = UDim2.new(0.5, 0, 0.5, 0)
panel.Size = UDim2.new(0, 520, 0, 320)
panel.BackgroundColor3 = Color3.fromRGB(8, 8, 15)
panel.BorderSizePixel = 0
panel.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = panel

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0, 255, 170)
stroke.Parent = panel

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -20, 0, 40)
title.Position = UDim2.new(0, 10, 0, 10)
title.Text = "WEAPON CRAFTING"
title.TextColor3 = Color3.fromRGB(0, 255, 170)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = panel

-- Left: weapon preview
local preview = Instance.new("Frame")
preview.Name = "Preview"
preview.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
preview.BorderSizePixel = 0
preview.Position = UDim2.new(0, 20, 0, 60)
preview.Size = UDim2.new(0, 220, 0, 200)
preview.Parent = panel

local pCorner = Instance.new("UICorner")
pCorner.CornerRadius = UDim.new(0, 12)
pCorner.Parent = preview

local pStroke = Instance.new("UIStroke")
pStroke.Thickness = 2
pStroke.Color = Color3.fromRGB(0, 200, 255)
pStroke.Parent = preview

local pTitle = Instance.new("TextLabel")
pTitle.BackgroundTransparency = 1
pTitle.Size = UDim2.new(1, -20, 0, 30)
pTitle.Position = UDim2.new(0, 10, 0, 10)
pTitle.Text = "PREVIEW"
pTitle.TextColor3 = Color3.fromRGB(0, 255, 220)
pTitle.Font = Enum.Font.GothamBold
pTitle.TextSize = 18
pTitle.TextXAlignment = Enum.TextXAlignment.Left
pTitle.Parent = preview

local pName = Instance.new("TextLabel")
pName.Name = "WeaponName"
pName.BackgroundTransparency = 1
pName.Size = UDim2.new(1, -20, 0, 30)
pName.Position = UDim2.new(0, 10, 0, 50)
pName.Text = "Select a weapon"
pName.TextColor3 = Color3.fromRGB(200, 255, 255)
pName.Font = Enum.Font.GothamBold
pName.TextSize = 18
pName.TextXAlignment = Enum.TextXAlignment.Left
pName.Parent = preview

local pDesc = Instance.new("TextLabel")
pDesc.Name = "WeaponDesc"
pDesc.BackgroundTransparency = 1
pDesc.Size = UDim2.new(1, -20, 0, 80)
pDesc.Position = UDim2.new(0, 10, 0, 80)
pDesc.Text = "Damage, tier, and flavor text go here."
pDesc.TextColor3 = Color3.fromRGB(180, 230, 255)
pDesc.Font = Enum.Font.Gotham
pDesc.TextSize = 14
pDesc.TextWrapped = true
pDesc.TextXAlignment = Enum.TextXAlignment.Left
pDesc.TextYAlignment = Enum.TextYAlignment.Top
pDesc.Parent = preview

-- Right: crafting info
local craftInfo = Instance.new("Frame")
craftInfo.Name = "CraftInfo"
craftInfo.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
craftInfo.BorderSizePixel = 0
craftInfo.Position = UDim2.new(0, 260, 0, 60)
craftInfo.Size = UDim2.new(0, 240, 0, 200)
craftInfo.Parent = panel

local cCorner = Instance.new("UICorner")
cCorner.CornerRadius = UDim.new(0, 12)
cCorner.Parent = craftInfo

local cStroke = Instance.new("UIStroke")
cStroke.Thickness = 2
cStroke.Color = Color3.fromRGB(0, 200, 255)
cStroke.Parent = craftInfo

local cTitle = Instance.new("TextLabel")
cTitle.BackgroundTransparency = 1
cTitle.Size = UDim2.new(1, -20, 0, 30)
cTitle.Position = UDim2.new(0, 10, 0, 10)
cTitle.Text = "REQUIREMENTS"
cTitle.TextColor3 = Color3.fromRGB(0, 255, 220)
cTitle.Font = Enum.Font.GothamBold
cTitle.TextSize = 18
cTitle.TextXAlignment = Enum.TextXAlignment.Left
cTitle.Parent = craftInfo

local reqText = Instance.new("TextLabel")
reqText.Name = "RequirementsText"
reqText.BackgroundTransparency = 1
reqText.Size = UDim2.new(1, -20, 0, 80)
reqText.Position = UDim2.new(0, 10, 0, 40)
reqText.Text = "Fragments required: 0"
reqText.TextColor3 = Color3.fromRGB(200, 255, 255)
reqText.Font = Enum.Font.Gotham
reqText.TextSize = 16
reqText.TextWrapped = true
reqText.TextXAlignment = Enum.TextXAlignment.Left
reqText.TextYAlignment = Enum.TextYAlignment.Top
reqText.Parent = craftInfo

local fragLabel = Instance.new("TextLabel")
fragLabel.Name = "FragmentCount"
fragLabel.BackgroundTransparency = 1
fragLabel.Size = UDim2.new(1, -20, 0, 30)
fragLabel.Position = UDim2.new(0, 10, 0, 130)
fragLabel.Text = "Your Fragments: 0"
fragLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
fragLabel.Font = Enum.Font.GothamBold
fragLabel.TextSize = 16
fragLabel.TextXAlignment = Enum.TextXAlignment.Left
fragLabel.Parent = craftInfo

local craftBtn = Instance.new("TextButton")
craftBtn.Name = "CraftButton"
craftBtn.Size = UDim2.new(0, 180, 0, 40)
craftBtn.Position = UDim2.new(0.5, 0, 1, -50)
craftBtn.AnchorPoint = Vector2.new(0.5, 0.5)
craftBtn.BackgroundColor3 = Color3.fromRGB(10, 20, 25)
craftBtn.BorderSizePixel = 0
craftBtn.Text = "CRAFT"
craftBtn.TextColor3 = Color3.fromRGB(0, 255, 170)
craftBtn.Font = Enum.Font.GothamBold
craftBtn.TextSize = 20
craftBtn.Parent = panel

local cbCorner = Instance.new("UICorner")
cbCorner.CornerRadius = UDim.new(0, 10)
cbCorner.Parent = craftBtn

local cbStroke = Instance.new("UIStroke")
cbStroke.Thickness = 2
cbStroke.Color = Color3.fromRGB(0, 255, 170)
cbStroke.Parent = craftBtn

return gui
