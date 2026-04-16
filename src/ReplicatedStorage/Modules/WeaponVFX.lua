local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local WeaponVFX = {}

---------------------------------------------------------------------
-- GENERIC SLASH TRAIL
---------------------------------------------------------------------
function WeaponVFX.SlashTrail(attachment)
    local trail = Instance.new("Trail")
    trail.Color = ColorSequence.new(Color3.fromRGB(0, 255, 170))
    trail.LightEmission = 1
    trail.Lifetime = 0.25
    trail.MinLength = 0.1
    trail.Attachment0 = attachment
    trail.Attachment1 = attachment
    trail.Parent = attachment.Parent

    Debris:AddItem(trail, 0.4)
end

---------------------------------------------------------------------
-- DUAL KATANA STREAK
---------------------------------------------------------------------
function WeaponVFX.DualKatanaStreak(root)
    for i = 1, 2 do
        local p = Instance.new("ParticleEmitter")
        p.Texture = "rbxassetid://1095708"
        p.Color = ColorSequence.new(Color3.fromRGB(0, 255, 170))
        p.Lifetime = NumberRange.new(0.2)
        p.Speed = NumberRange.new(20)
        p.Rate = 300
        p.Parent = root

        task.delay(0.1, function()
            p.Enabled = false
            Debris:AddItem(p, 0.3)
        end)
    end
end

---------------------------------------------------------------------
-- HAMMER IMPACT SHOCKWAVE
---------------------------------------------------------------------
function WeaponVFX.HammerImpact(position)
    local ring = Instance.new("Part")
    ring.Anchored = true
    ring.CanCollide = false
    ring.Size = Vector3.new(1, 0.2, 1)
    ring.Material = Enum.Material.Neon
    ring.Color = Color3.fromRGB(0, 255, 170)
    ring.CFrame = CFrame.new(position)
    ring.Parent = workspace

    TweenService:Create(ring, TweenInfo.new(0.3), {
        Size = Vector3.new(15, 0.2, 15),
        Transparency = 1
    }):Play()

    Debris:AddItem(ring, 0.4)
end

---------------------------------------------------------------------
-- BATON ELECTRIC SPARK
---------------------------------------------------------------------
function WeaponVFX.BatonSpark(position)
    local p = Instance.new("ParticleEmitter")
    p.Texture = "rbxassetid://258128463"
    p.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
    p.Lifetime = NumberRange.new(0.2)
    p.Speed = NumberRange.new(15)
    p.Rate = 200
    p.Parent = workspace.Terrain

    p:Emit(20)
    Debris:AddItem(p, 0.3)
end

return WeaponVFX
