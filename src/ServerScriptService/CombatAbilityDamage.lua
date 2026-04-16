local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local AbilityData = require(ReplicatedStorage.Modules.AbilityData)

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local AbilityDamageRemote = Remotes:WaitForChild("AbilityDamage")

local function applyDamageInRadius(origin, radius, damage, sourcePlayer)
    local ignore = {}
    if sourcePlayer.Character then
        table.insert(ignore, sourcePlayer.Character)
    end

    local region = Region3.new(
        origin - Vector3.new(radius, radius, radius),
        origin + Vector3.new(radius, radius, radius)
    )

    local parts = workspace:FindPartsInRegion3WithIgnoreList(region, ignore, 100)
    local hitHumanoids = {}

    for _, part in ipairs(parts) do
        local model = part:FindFirstAncestorOfClass("Model")
        if model then
            local hum = model:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 and not hitHumanoids[hum] then
                hitHumanoids[hum] = true
                hum:TakeDamage(damage)
            end
        end
    end
end

AbilityDamageRemote.OnServerEvent:Connect(function(player, abilityId, originCFrame)
    local data = AbilityData.GetAbility(abilityId)
    if not data then return end

    if abilityId == "ShockwaveBurst" then
        applyDamageInRadius(originCFrame.Position, 12, 25, player)
    elseif abilityId == "GroundSlam" then
        applyDamageInRadius(originCFrame.Position, 16, 35, player)
    elseif abilityId == "GravityCrush" then
        applyDamageInRadius(originCFrame.Position, 20, 45, player)
    end
end)
