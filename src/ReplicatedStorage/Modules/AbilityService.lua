local AbilityService = {}

local AbilityData = require(game.ReplicatedStorage.Modules.AbilityData)

-- XP curve: ~2h per ability unlock, you can tune this later
local LevelXP = {
    [1] = 500,
    [2] = 1000,
    [3] = 2000,
    [4] = 3500,
    [5] = 5000,
    [6] = 7000,
    [7] = 9000,
    [8] = 12000,
    [9] = 15000,
}

local function getXPForLevel(level)
    return LevelXP[level] or (15000 + (level - 9) * 3000)
end

function AbilityService.GetDefaultAbilityData()
    -- Deep copy
    local base = AbilityData.Default
    return {
        Level = base.Level,
        XP = base.XP,
        AbilitySlots = {
            Slot1 = base.AbilitySlots.Slot1,
            Slot2 = base.AbilitySlots.Slot2,
            Slot3 = base.AbilitySlots.Slot3,
            Slot4 = base.AbilitySlots.Slot4,
        },
        UnlockedAbilities = {
            AirStep = true,
        }
    }
end

function AbilityService.AddXP(abilityState, amount)
    abilityState.XP += amount
    while abilityState.XP >= getXPForLevel(abilityState.Level) do
        abilityState.XP -= getXPForLevel(abilityState.Level)
        abilityState.Level += 1
    end
end

function AbilityService.CanUseSlot(abilityState, slotIndex)
    local level = abilityState.Level
    if slotIndex == 1 then
        return true
    elseif slotIndex == 2 then
        return level >= 10
    elseif slotIndex == 3 then
        return level >= 10
    elseif slotIndex == 4 then
        return level >= 20
    end
    return false
end

function AbilityService.AssignAbilityToSlot(abilityState, abilityId, slotIndex)
    if not abilityState.UnlockedAbilities[abilityId] then return false end
    if not AbilityService.CanUseSlot(abilityState, slotIndex) then return false end

    local slotName = "Slot" .. tostring(slotIndex)
    abilityState.AbilitySlots[slotName] = abilityId
    return true
end

function AbilityService.UnlockAbility(abilityState, abilityId)
    abilityState.UnlockedAbilities[abilityId] = true
end

function AbilityService.GetAbilityFromSlot(abilityState, slotIndex)
    local slotName = "Slot" .. tostring(slotIndex)
    return abilityState.AbilitySlots[slotName]
end

return AbilityService
