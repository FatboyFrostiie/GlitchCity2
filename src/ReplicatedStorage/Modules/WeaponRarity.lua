local WeaponRarity = {}

WeaponRarity.Rarities = {
    Common = {Color = Color3.fromRGB(180, 180, 180), Multiplier = 1.0},
    Rare = {Color = Color3.fromRGB(0, 170, 255), Multiplier = 1.2},
    Epic = {Color = Color3.fromRGB(170, 0, 255), Multiplier = 1.5},
    Legendary = {Color = Color3.fromRGB(255, 200, 0), Multiplier = 2.0},
}

function WeaponRarity.Roll()
    local r = math.random()
    if r < 0.6 then return "Common" end
    if r < 0.85 then return "Rare" end
    if r < 0.97 then return "Epic" end
    return "Legendary"
end

function WeaponRarity.Apply(baseDamage, rarityId)
    local data = WeaponRarity.Rarities[rarityId] or WeaponRarity.Rarities.Common
    return baseDamage * data.Multiplier
end

return WeaponRarity
