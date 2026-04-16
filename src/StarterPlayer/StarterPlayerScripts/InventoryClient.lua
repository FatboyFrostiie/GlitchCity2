local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local WeaponService = require(ReplicatedStorage.Modules.WeaponService)
local UIIcons = require(ReplicatedStorage.Modules.UIIcons)
local UIManager = require(ReplicatedStorage.Modules.UIManager)
local NeonUIEffects = require(ReplicatedStorage.Modules.NeonUIEffects)

local gui = PlayerGui:WaitForChild("InventoryUI")
local grid = gui.MainPanel.WeaponGrid
local statsText = gui.MainPanel.StatsPanel.StatsText
local fragLabel = gui.MainPanel.FragmentLabel
local equipBtn = gui.MainPanel.EquipButton
local craftBtn = gui.MainPanel.CraftButton

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local EquipRemote = Remotes:FindFirstChild("EquipWeapon") or Instance.new("RemoteEvent", Remotes)
EquipRemote.Name = "EquipWeapon"

local CraftRemote = Remotes:FindFirstChild("CraftWeapon") or Instance.new("RemoteEvent", Remotes)
CraftRemote.Name = "CraftWeapon"

local selectedWeaponId

local function getInventory()
    -- Replace with your real data
    return {
        Weapons = {
            Fists = true,
            NeonHammer = true,
        },
        Fragments = 0,
    }
end

local function refreshFragments()
    local inv = getInventory()
    fragLabel.Text = "Fragments: " .. tostring(inv.Fragments or 0)
end

local function clearGrid()
    for _, child in ipairs(grid:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
end

local function selectWeapon(id)
    selectedWeaponId = id
    local data = WeaponService.GetWeaponData(id)
    if not data then
        statsText.Text = "Select a weapon..."
        return
    end

    statsText.Text = string.format(
        "%s\n\nDamage: %d\nRange: %.1f\nTier: %d",
        data.Name,
        data.Damage,
        data.Range,
        data.Tier
    )
end

local function createWeaponSlot(id)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 80, 0, 80)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    frame.BorderSizePixel = 0
    frame.Parent = grid

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(40, 40, 50)
    stroke.Parent = frame

    NeonUIEffects.PulseStroke(stroke, 2, 1.5, 2.5)

    local icon = Instance.new("ImageButton")
    icon.BackgroundTransparency = 1
    icon.Size = UDim2.new(0.8, 0, 0.8, 0)
    icon.Position = UDim2.new(0.5, 0, 0.5, 0)
    icon.AnchorPoint = Vector2.new(0.5, 0.5)
    icon.Image = UIIcons.Weapons[id] or "rbxassetid://0"
    icon.Parent = frame

    icon.MouseButton1Click:Connect(function()
        selectWeapon(id)
    end)
end

local function refreshGrid()
    clearGrid()
    local inv = getInventory()
    for id, owned in pairs(inv.Weapons) do
        if owned then
            createWeaponSlot(id)
        end
    end
end

equipBtn.MouseButton1Click:Connect(function()
    if not selectedWeaponId then return end
    EquipRemote:FireServer(selectedWeaponId)
end)

craftBtn.MouseButton1Click:Connect(function()
    if not selectedWeaponId then return end
    CraftRemote:FireServer(selectedWeaponId)
end)

refreshGrid()
refreshFragments()

return true
