local HotbarService = {}

-- 4 slots, melee weapons only
-- data.Hotbar = { "Fists", nil, nil, nil }

function HotbarService.GetDefaultHotbar()
    return { "Fists", nil, nil, nil }
end

function HotbarService.SetSlot(hotbar, slotIndex, weaponId)
    if slotIndex < 1 or slotIndex > 4 then return end
    hotbar[slotIndex] = weaponId
end

function HotbarService.GetEquippedFromSlot(hotbar, slotIndex)
    return hotbar[slotIndex]
end

function HotbarService.CycleSlot(currentIndex, direction)
    local newIndex = currentIndex + direction
    if newIndex < 1 then newIndex = 4 end
    if newIndex > 4 then newIndex = 1 end
    return newIndex
end

return HotbarService
