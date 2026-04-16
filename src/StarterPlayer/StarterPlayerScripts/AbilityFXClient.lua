local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local AbilityVFX = require(ReplicatedStorage.Modules.AbilityVFX)
local AbilitySounds = require(ReplicatedStorage.Modules.AbilitySounds)
local AbilityAnimations = require(ReplicatedStorage.Modules.AbilityAnimations)

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local AbilityUsedRemote = Remotes:WaitForChild("AbilityUsed")

AbilityUsedRemote.OnClientEvent:Connect(function(slotIndex, abilityId)
    local char = player.Character
    if not char then return end

    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    -- Play animation
    AbilityAnimations.Play(char, abilityId)

    -- Play sound
    AbilitySounds.Play(char, abilityId)

    -- Play VFX
    if abilityId == "AirStep" then
        AbilityVFX.AirStepBurst(root)
    elseif abilityId == "Dash" then
        AbilityVFX.DashTrail(char)
    elseif abilityId == "ShockwaveBurst" then
        AbilityVFX.ShockwaveBurst(root.Position)
    elseif abilityId == "GroundSlam" then
        AbilityVFX.GroundSlam(root.Position)
    elseif abilityId == "GravityCrush" then
        AbilityVFX.GravityCrush(root.Position)
    end
end)
