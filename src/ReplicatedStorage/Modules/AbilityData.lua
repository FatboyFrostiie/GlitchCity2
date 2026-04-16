local AbilityData = {}

-- Slots:
-- Slot1 -> Q
-- Slot2 -> E
-- Slot3 -> R (mid-level)
-- Slot4 -> F (high-level)
-- Counter and DoubleJump are always-on defaults

AbilityData.Default = {
    Level = 1,
    XP = 0,
    AbilitySlots = {
        Slot1 = "AirStep",
        Slot2 = nil,
        Slot3 = nil,
        Slot4 = nil,
    },
    UnlockedAbilities = {
        AirStep = true,
    }
}

AbilityData.Abilities = {
    DoubleJump = {
        Id = "DoubleJump",
        Name = "Double Jump",
        Type = "Movement",
        Default = true,
    },

    Counter = {
        Id = "Counter",
        Name = "Counter",
        Type = "Combat",
        Default = true,
        Cooldown = 8,
        Window = 0.25,
    },

    AirStep = {
        Id = "AirStep",
        Name = "Air Step",
        Type = "Movement",
        Cooldown = 6,
    },

    Dash = {
        Id = "Dash",
        Name = "Dash",
        Type = "Movement",
        Cooldown = 5,
        UnlockLevel = 3,
    },

    ShockwaveBurst = {
        Id = "ShockwaveBurst",
        Name = "Shockwave Burst",
        Type = "Combat",
        Cooldown = 10,
        UnlockLevel = 4,
    },

    Blink = {
        Id = "Blink",
        Name = "Blink",
        Type = "Movement",
        Cooldown = 7,
        UnlockLevel = 5,
    },

    SpinSlash = {
        Id = "SpinSlash",
        Name = "Spin Slash",
        Type = "Combat",
        Cooldown = 9,
        UnlockLevel = 6,
    },

    GroundSlam = {
        Id = "GroundSlam",
        Name = "Ground Slam",
        Type = "Hybrid",
        Cooldown = 10,
        UnlockLevel = 7,
    },

    TeleportStrike = {
        Id = "TeleportStrike",
        Name = "Teleport Strike",
        Type = "Hybrid",
        Cooldown = 12,
        UnlockLevel = 8,
    },

    PhantomDash = {
        Id = "PhantomDash",
        Name = "Phantom Dash",
        Type = "Movement",
        Cooldown = 8,
        UnlockLevel = 9,
    },

    GravityCrush = {
        Id = "GravityCrush",
        Name = "Gravity Crush",
        Type = "Hybrid",
        Cooldown = 14,
        UnlockLevel = 10,
    },
}

function AbilityData.GetAbility(id)
    return AbilityData.Abilities[id]
end

return AbilityData
