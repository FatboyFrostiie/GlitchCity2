local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local AbilityService = require(ReplicatedStorage.Modules.AbilityService)
local AbilityData = require(ReplicatedStorage.Modules.AbilityData)
local NeonUIEffects = require(ReplicatedStorage.Modules.NeonUIEffects)

local gui = PlayerGui:WaitForChild("AbilitySelectionUI")
local panel = gui.AbilityPanel
local listFrame = panel.AbilityList
local slotsFrame = panel.EquippedSlots
local xpBar = panel.XPBar
local xpFill = xpBar.Fill
local xpLabel = xpBar:FindFirstChildOfClass("TextLabel")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local XPRemote = Remotes:WaitForChild("AddAbilityXP")

local state = AbilityService.GetDefaultAbilityData()

local function updateXPBar()
    local level = state.Level
    local xp = state.XP
    local needed = require(ReplicatedStorage.Modules.ProgressionConfig).GetXPForLevel(level)

    local ratio = needed > 0 and math.clamp(xp / needed, 0, 1) or 0
    xpFill.Size = UDim2.new(ratio, 0, 1, 0)
    xpLabel.Text = string.format("XP: %d / %d  (Lv %d)", xp, needed, level)
end

local function refreshSlots()
    local rows = {}
    for _, child in ipairs(slotsFrame:GetChildren()) do
        if child:IsA("Frame") then
            table.insert(rows, child)
        end
    end

    for i = 1, 4 do
        local row = rows[i]
        if row then
            local label = row:FindFirstChild("AbilityName")
            if label then
                local abilityId = AbilityService.GetAbilityFromSlot(state, i)
                label.Text = abilityId and (AbilityData.GetAbility(abilityId).Name) or "Empty"
            end
        end
    end
end

local function clearList()
    for _, child in ipairs(listFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
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
    nameLabel.Size = UDim2.new(0.5, 0, 1, 0)
    nameLabel.Position = UDim2.new(0, 10, 0, 0)
    nameLabel.Text = data.Name
    nameLabel.TextColor3 = Color3.fromRGB(200, 255, 255)
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.TextSize = 16
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = row

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.25, -10, 0, 28)
    btn.Position = UDim2.new(0.75, 0, 0.5, 0)
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
        AbilityService.AssignAbilityToSlot(state, id, 1)
        refreshSlots()
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
refreshSlots()
updateXPBar()

return true
