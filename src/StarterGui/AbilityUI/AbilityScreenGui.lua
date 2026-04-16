local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "AbilityUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = PlayerGui

local function neonButton(parent, name, labelText, anchor, pos)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.AnchorPoint = anchor
    frame.Position = pos
    frame.Size = UDim2.new(0, 70, 0, 70)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    frame.BorderSizePixel = 0
    frame.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0, 255, 170)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = frame

    local glow = Instance.new("ImageLabel")
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://4996891970"
    glow.ImageColor3 = Color3.fromRGB(0, 255, 170)
    glow.Size = UDim2.new(1.4, 0, 1.4, 0)
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.ImageTransparency = 0.7
    glow.ZIndex = 0
    glow.Parent = frame

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Position = UDim2.new(0, 0, 1, -20)
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(0, 255, 170)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.Parent = frame

    local cd = Instance.new("Frame")
    cd.Name = "CooldownOverlay"
    cd.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    cd.BackgroundTransparency = 0.6
    cd.Size = UDim2.new(1, 0, 1, 0)
    cd.Visible = false
    cd.Parent = frame

    local cdLabel = Instance.new("TextLabel")
    cdLabel.BackgroundTransparency = 1
    cdLabel.Size = UDim2.new(1, 0, 1, 0)
    cdLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
    cdLabel.Font = Enum.Font.GothamBold
    cdLabel.TextSize = 18
    cdLabel.Text = "0"
    cdLabel.Parent = cd

    return frame
end

-- Right side ability cluster (Q/E/R/F)
local cluster = Instance.new("Frame")
cluster.Name = "AbilityCluster"
cluster.AnchorPoint = Vector2.new(1, 0.5)
cluster.Position = UDim2.new(1, -40, 0.5, 0)
cluster.Size = UDim2.new(0, 90, 0, 320)
cluster.BackgroundTransparency = 1
cluster.Parent = gui

local list = Instance.new("UIListLayout")
list.FillDirection = Enum.FillDirection.Vertical
list.HorizontalAlignment = Enum.HorizontalAlignment.Center
list.VerticalAlignment = Enum.VerticalAlignment.Center
list.Padding = UDim.new(0, 10)
list.Parent = cluster

neonButton(cluster, "Slot1", "Q", Vector2.new(0.5, 0.5), UDim2.new(0.5, 0, 0, 0))
neonButton(cluster, "Slot2", "E", Vector2.new(0.5, 0.5), UDim2.new(0.5, 0, 0, 0))
neonButton(cluster, "Slot3", "R", Vector2.new(0.5, 0.5), UDim2.new(0.5, 0, 0, 0))
neonButton(cluster, "Slot4", "F", Vector2.new(0.5, 0.5), UDim2.new(0.5, 0, 0, 0))

-- Left side Counter button
neonButton(gui, "CounterButton", "RMB / LB", Vector2.new(0, 0.5), UDim2.new(0, 40, 0.5, 0))

return gui
