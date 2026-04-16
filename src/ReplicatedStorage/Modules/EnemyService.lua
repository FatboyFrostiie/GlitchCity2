local EnemyService = {}

-- Enemy definitions
EnemyService.Enemies = {
    DataWraith = {
        health = 100,
        damage = 15,
        speed = 2,
        abilities = {"Shadow Strike", "Teleport"}
    },
    CorruptedDrone = {
        health = 80,
        damage = 20,
        speed = 3,
        abilities = {"Laser Beam", "Self-Destruct"}
    },
    VoidWalker = {
        health = 120,
        damage = 25,
        speed = 1,
        abilities = {"Void Pulse", "Time Warp"}
    },
    FracturedGiant = {
        health = 200,
        damage = 30,
        speed = 1,
        abilities = {"Ground Slam", "Aoe Shockwave"}
    },
    GlitchTitan = {
        health = 300,
        damage = 40,
        speed = 0.5,
        abilities = {"Glitch Wave", "Titanic Smash"}
    }
}

return EnemyService