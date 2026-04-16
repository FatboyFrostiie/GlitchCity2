local AbilityAnimations = {}

AbilityAnimations.Library = {
    Dash = "rbxassetid://13817547456",
    AirStep = "rbxassetid://13817547456",
    Shockwave = "rbxassetid://13817547456",
    GroundSlam = "rbxassetid://13817547456",
    GravityCrush = "rbxassetid://13817547456",
    Counter = "rbxassetid://13817547456",
    Blink = "rbxassetid://13817547456",
}

function AbilityAnimations.Play(character, animName)
    local hum = character:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    local id = AbilityAnimations.Library[animName]
    if not id then return end

    local anim = Instance.new("Animation")
    anim.AnimationId = id

    local track = hum:LoadAnimation(anim)
    track:Play()
end

return AbilityAnimations
