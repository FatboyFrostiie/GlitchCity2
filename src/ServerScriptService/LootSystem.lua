local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LootSystem = {}

LootSystem.Table = {
    {ItemId = "Fragments", Chance = 0.6, Min = 1, Max = 3},
    {ItemId = "Weapon_NeonHammer", Chance = 0.1},
    {ItemId = "Weapon_EnergyBlade", Chance = 0.05},
}

local function rollLoot()
    local drops = {}
    for _, entry in ipairs(LootSystem.Table) do
        if math.random() < entry.Chance then
            local amount = entry.Min and math.random(entry.Min, entry.Max or entry.Min) or 1
            table.insert(drops, {ItemId = entry.ItemId, Amount = amount})
        end
    end
    return drops
end

function LootSystem.DropAt(position, player)
    local drops = rollLoot()
    -- Here you’d add to player’s inventory / fragments
    -- Example: give fragments
    for _, drop in ipairs(drops) do
        if drop.ItemId == "Fragments" then
            -- Add fragments to player data
        end
    end
end

return LootSystem
