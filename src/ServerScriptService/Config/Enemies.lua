local Enemies = {
    NeonCore = {
        Type = "FloatingDrone",
        Count = 10,
        PatrolRadius = 180,
        AggroRange = 120,
        ShockwaveRadius = 25,
        MaxHealth = 150,
    },
    IndustrialSector = {
        Type = "QuadMech",
        Count = 10,
        PatrolRadius = 180,
        AggroRange = 120,
        ShockwaveRadius = 30,
        MaxHealth = 200,
    },
    SkyDistrict = {
        Type = "HumanoidSentinel",
        Count = 10,
        PatrolRadius = 180,
        AggroRange = 130,
        ShockwaveRadius = 28,
        MaxHealth = 180,
    },
    GlitchWasteland = {
        Type = "GlitchHorror",
        Count = 10,
        PatrolRadius = 180,
        AggroRange = 130,
        ShockwaveRadius = 30,
        MaxHealth = 190,
    },
    DataTunnels = {
        Type = "HologramConstruct",
        Count = 10,
        PatrolRadius = 180,
        AggroRange = 130,
        ShockwaveRadius = 26,
        MaxHealth = 170,
    },
}

return Enemies
