local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local AbilityService = require(ReplicatedStorage.Modules.AbilityService)
local AbilityData = require(ReplicatedStorage.Modules.AbilityData)
local UIIcons = require(ReplicatedStorage.Modules.UIIcons)
local NeonUIEffects = require(ReplicatedStorage.Modules.NeonUIEffects)

local gui = PlayerGui:WaitForChild("AbilityUI")
local cluster = gui:WaitForChild("AbilityCluster")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local AbilityRemote = Remotes:WaitForChild("UseAbility")

local slotFrames = {
    [1] = cluster.Slot1,
    [2] = cluster.Slot2,
    [3] = cluster.Slot3,
    [4] = cluster.Slot4,
}

local function getAbilityState()
    -- Replace with your real data
    return AbilityService.GetDefaultAbilityData()
end

local function updateSlots()
    local state = getAbilityState()
    for i = 1, 4 do
        local frame = slotFrames[i]
        local cdOverlay = frame:FindFirstChild("CooldownOverlay")
        local abilityId = AbilityService.GetAbilityFromSlot(state, i)
        local icon = frame:FindFirstChild("Icon")
        if not icon then
            icon = Instance.new("ImageLabel")
            icon.Name = "Icon"
            icon.BackgroundTransparency = 1
            icon.Size = UDim2.new(0.7, 0, 0.7, 0)
            icon.Position = UDim2.new(0.5, 0, 0.5, 0)
            icon.AnchorPoint = Vector2.new(0.5, 0.5)
            icon.Parent = frame
        end

        if abilityId then
            icon.Image = UIIcons.Abilities[abilityId] or "rbxassetid://0"
            icon.ImageTransparency = 0
        else
            icon.Image = ""
            icon.ImageTransparency = 1
        end

        if cdOverlay then
            cdOverlay.Visible = false
        end
    end
end

for _, frame in pairs(slotFrames) do
    local stroke = frame:FindFirstChildOfClass("UIStroke")
    if stroke then
        NeonUIEffects.PulseStroke(stroke, 2, 1.5, 2.5)
    end
end

updateSlots()

return true
