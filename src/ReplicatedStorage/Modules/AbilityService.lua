-- Ability Definitions

local abilities = {
    jumpBoost = {
        description = "Increases jump height",
        unlocked = false,
    },
    speedBoost = {
        description = "Increases movement speed",
        unlocked = false,
    },
    invisibility = {
        description = "Makes player invisible",
        unlocked = false,
    },
}

-- Function to get unlocked abilities
local function GetUnlockedAbilities()
    local unlockedAbilities = {}
    for ability, data in pairs(abilities) do
        if data.unlocked then
            table.insert(unlockedAbilities, ability)
        end
    end
    return unlockedAbilities
end

return {
    abilities = abilities,
    GetUnlockedAbilities = GetUnlockedAbilities,
}