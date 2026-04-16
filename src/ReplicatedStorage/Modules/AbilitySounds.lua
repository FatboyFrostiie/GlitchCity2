local AbilitySounds = {}

AbilitySounds.Library = {
    Dash = "rbxassetid://9118822711",
    AirStep = "rbxassetid://9118822711",
    Shockwave = "rbxassetid://9118822711",
    GroundSlam = "rbxassetid://9118822711",
    GravityCrush = "rbxassetid://9118822711",
    Counter = "rbxassetid://9118822711",
    Blink = "rbxassetid://9118822711",
}

function AbilitySounds.Play(character, soundName)
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local id = AbilitySounds.Library[soundName]
    if not id then return end

    local s = Instance.new("Sound")
    s.SoundId = id
    s.Volume = 1
    s.PlayOnRemove = true
    s.Parent = root
    s:Destroy()
end

return AbilitySounds
