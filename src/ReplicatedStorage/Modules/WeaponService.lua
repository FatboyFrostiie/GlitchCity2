local WeaponService = {}

-- Base damage for starter fists
local BASE_DAMAGE = 10

WeaponService.Weapons = {
    Fists = {
        Id = "Fists",
        Name = "Fists",
        Damage = BASE_DAMAGE,
        Range = 6,
        SwingTime = 0.4,
        Cooldown = 0.3,
        Tier = 1,
        Neon = false,
        Dual = false,
    },

    NeonHammer = {
        Id = "NeonHammer",
        Name = "Neon Hammer",
        Damage = math.floor(BASE_DAMAGE * 1.15),
        Range = 7,
        SwingTime = 0.7,
        Cooldown = 0.6,
        Tier = 2,
        Neon = true,
        Dual = false,
    },

    EnergyBlade = {
        Id = "EnergyBlade",
        Name = "Neon Energy Blade",
        Damage = math.floor(BASE_DAMAGE * 1.15 * 1.15),
        Range = 8,
        SwingTime = 0.5,
        Cooldown = 0.45,
        Tier = 3,
        Neon = true,
        Dual = false,
    },

    ShockBaton = {
        Id = "ShockBaton",
        Name = "Neon Shock Baton",
        Damage = math.floor(BASE_DAMAGE * 1.15^3),
        Range = 7.5,
        SwingTime = 0.45,
        Cooldown = 0.4,
        Tier = 4,
        Neon = true,
        Dual = false,
    },

    DualKatanas = {
        Id = "DualKatanas",
        Name = "Dual Neon Katanas",
        Damage = math.floor(BASE_DAMAGE * 1.15^4),
        Range = 8.5,
        SwingTime = 0.4,
        Cooldown = 0.35,
        Tier = 5,
        Neon = true,
        Dual = true,
    }
}

-- Simple inventory structure:
-- data.Weapons = { [weaponId] = true, ... }
-- data.EquippedWeapon = "Fists"

function WeaponService.GetWeaponData(id)
    return WeaponService.Weapons[id]
end

function WeaponService.GetDefaultInventory()
    return {
        Weapons = {
            Fists = true,
        },
        EquippedWeapon = "Fists",
    }
end

function WeaponService.EquipWeapon(playerData, weaponId)
    if not playerData.Weapons[weaponId] then return false end
    playerData.EquippedWeapon = weaponId
    return true
end

return WeaponService
