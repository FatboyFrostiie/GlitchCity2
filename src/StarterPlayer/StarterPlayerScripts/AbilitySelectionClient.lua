local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local AbilityService = require(ReplicatedStorage.Modules.AbilityService)
local AbilityData = require(ReplicatedStorage.Modules.AbilityData)
local UIIcons = require(ReplicatedStorage.Modules.UIIcons)
local NeonUIEffects = require(ReplicatedStorage.Modules.NeonUIEffects)

local gui = PlayerGui:WaitForChild("AbilitySelectionUI")
local listFrame = gui.AbilityPanel.AbilityList
local slotsFrame = gui.AbilityPanel.EquippedSlots
local xpBar = gui.AbilityPanel.XPBar
local xpFill = xpBar.Fill
local xpLabel = xpBar:FindFirstChildOfClass("TextLabel")

local function getState()
    return AbilityService.GetDefaultAbilityData()
end

local function clearList()
    for _, child in ipairs(listFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
end

local function createAbilityRow(id, data)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 40)
    row.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
    row.BorderSizePixel = 0
    row.Parent = listFrame

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = row

    local s = Instance.new("UIStroke")
    s.Thickness = 1.5
    s.Color = Color3.fromRGB(0, 255, 170)
    s.Parent = row

    NeonUIEffects.PulseStroke(s, 2, 1, 2)

    local nameLabel = Instance.new("TextLabel")
    nameLabel.BackgroundTransparency = 1
    nameLabel.Size = UDim2.new(0.6, 0, 1, 0)
    nameLabel.Position = UDim2.new(0, 10, 0, 0)
    nameLabel.Text = data.Name
    nameLabel.TextColor3 = Color3.fromRGB(200, 255, 255)
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.TextSize = 16
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = row

    local typeLabel = Instance.new("TextLabel")
    typeLabel.BackgroundTransparency = 1
    typeLabel.Size = UDim2.new(0.2, 0, 1, 0)
    typeLabel.Position = UDim2.new(0.6, 0, 0, 0)
    typeLabel.Text = data.Type or "?"
    typeLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
    typeLabel.Font = Enum.Font.Gotham
    typeLabel.TextSize = 14
    typeLabel.Parent = row

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.2, -10, 0, 28)
    btn.Position = UDim2.new(0.8, 0, 0.5, 0)
    btn.AnchorPoint = Vector2.new(0, 0.5)
    btn.BackgroundColor3 = Color3.fromRGB(10, 20, 25)
    btn.BorderSizePixel = 0
    btn.Text = "ASSIGN"
    btn.TextColor3 = Color3.fromRGB(0, 255, 170)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = row

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 8)
    bc.Parent = btn

    NeonUIEffects.HoverButton(btn)

    btn.MouseButton1Click:Connect(function()
        -- You can open a small popup to choose which slot (Q/E/R/F)
        -- For now, assign to Slot1 as example:
        local state = getState()
        AbilityService.AssignAbilityToSlot(state, id, 1)
    end)
end

local function refreshList()
    clearList()
    for id, data in pairs(AbilityData.Abilities) do
        if not data.Default then
            createAbilityRow(id, data)
        end
    end
end

refreshList()

return true
