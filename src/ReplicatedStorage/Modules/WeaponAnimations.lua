local WeaponAnimations = {}

WeaponAnimations.Library = {
    Fists = "rbxassetid://13817547456",
    NeonHammer = "rbxassetid://13817547456",
    EnergyBlade = "rbxassetid://13817547456",
    ShockBaton = "rbxassetid://13817547456",
    DualKatanas = "rbxassetid://13817547456",
}

function WeaponAnimations.Play(character, weaponId)
    local hum = character:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    local id = WeaponAnimations.Library[weaponId]
    if not id then return end

    local anim = Instance.new("Animation")
    anim.AnimationId = id

    local track = hum:LoadAnimation(anim)
    track:Play()
end

return WeaponAnimations
