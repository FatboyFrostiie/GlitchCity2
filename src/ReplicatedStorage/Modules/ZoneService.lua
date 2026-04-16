-- Zone definitions
local zones = {
    ZoneA = { stability = 100, uniqueId = "zoneA" },
    ZoneB = { stability = 80, uniqueId = "zoneB" },
    ZoneC = { stability = 60, uniqueId = "zoneC" }
}

-- Function to add stability to a zone
local function AddStability(zoneName, amount)
    if zones[zoneName] then
        zones[zoneName].stability = zones[zoneName].stability + amount
        return zones[zoneName].stability
    else
        error("Zone not found: " .. zoneName)
    end
end

return {
    zones = zones,
    AddStability = AddStability
}