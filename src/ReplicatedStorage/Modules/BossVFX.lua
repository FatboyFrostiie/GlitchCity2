local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local BossVFX = {}

---------------------------------------------------------------------
-- GIANT LASER BEAM
---------------------------------------------------------------------
function BossVFX.LaserBeam(origin, direction)
    local beam = Instance.new("Part")
    beam.Anchored = true
    beam.CanCollide = false
    beam.Material = Enum.Material.Neon
    beam.Color = Color3.fromRGB(255, 0, 80)
    beam.Size = Vector3.new(1, 1, 200)
    beam.CFrame = CFrame.new(origin, origin + direction)
    beam.Parent = workspace

    TweenService:Create(beam, TweenInfo.new(0.4), {Transparency = 1}):Play()
    Debris:AddItem(beam, 0.5)
end

---------------------------------------------------------------------
-- BOSS GROUND SHATTER
---------------------------------------------------------------------
function BossVFX.GroundShatter(position)
    for i = 1, 12 do
        local shard = Instance.new("Part")
        shard.Size = Vector3.new(2, 2, 2)
        shard.Material = Enum.Material.Neon
        shard.Color = Color3.fromRGB(255, 0, 80)
        shard.Anchored = false
        shard.CanCollide = false
        shard.CFrame = CFrame.new(position)
        shard.Parent = workspace

        shard.Velocity = Vector3.new(
            math.random(-40, 40),
            math.random(50, 80),
            math.random(-40, 40)
        )

        Debris:AddItem(shard, 0.6)
    end
end

return BossVFX
