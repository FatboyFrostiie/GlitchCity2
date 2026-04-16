local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local WeaponService = require(ReplicatedStorage.Modules.WeaponService)
local UIManager = require(ReplicatedStorage.Modules.UIManager)
local NeonUIEffects = require(ReplicatedStorage.Modules.NeonUIEffects)

local gui = PlayerGui:WaitForChild("CraftingUI")
local preview = gui.CraftPanel.Preview
local info = gui.CraftPanel.CraftInfo
local craftBtn = gui.CraftPanel.CraftButton

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local CraftRemote = Remotes:FindFirstChild("CraftWeapon") or Instance.new("RemoteEvent", Remotes)
CraftRemote.Name = "CraftWeapon"

local selectedWeaponId

local function getFragments()
    -- Replace with your real data
    return 0
end

local function getCost(id)
    local data = WeaponService.GetWeaponData(id)
    if not data then return 0 end
    if data.Tier == 2 then return 50 end
    if data.Tier == 3 then return 75 end
    if data.Tier == 4 then return 100 end
    if data.Tier == 5 then return 150 end
    return 0
end

local function selectWeapon(id)
    selectedWeaponId = id
    local data = WeaponService.GetWeaponData(id)
    if not data then
        preview.WeaponName.Text = "Select a weapon"
        preview.WeaponDesc.Text = ""
        return
    end

    preview.WeaponName.Text = data.Name
    preview.WeaponDesc.Text = string.format(
        "Damage: %d\nRange: %.1f\nTier: %d\n\nA neon cyber melee weapon.",
        data.Damage,
        data.Range,
        data.Tier
    )

    local cost = getCost(id)
    info.RequirementsText.Text = "Fragments required: " .. tostring(cost)
    info.FragmentCount.Text = "Your Fragments: " .. tostring(getFragments())
end

craftBtn.MouseButton1Click:Connect(function()
    if not selectedWeaponId then return end
    CraftRemote:FireServer(selectedWeaponId)
end)

local stroke = gui.CraftPanel:FindFirstChildOfClass("UIStroke")
if stroke then
    NeonUIEffects.PulseStroke(stroke, 1.5, 1.5, 3)
end

return true
