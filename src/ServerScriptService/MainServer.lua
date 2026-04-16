-- MainServer.lua

-- Player Initialization
local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player) 
    -- Initialize player properties
    player:SetAttribute("Coins", 0)
    player:SetAttribute("Level", 1)
    -- More initialization logic here 
end)

-- Abilities
local function grantAbility(player, abilityName)
    -- Logic to grant an ability to the player
    print(player.Name .. " has been granted the ability: " .. abilityName)
end

-- Rewards System
local function giveReward(player, reward)
    local coins = player:GetAttribute("Coins")
    player:SetAttribute("Coins", coins + reward)
    print(player.Name .. " has received " .. reward .. " coins!")
end

-- This can be called on triggers or events that reward players
-- Example: giveReward(somePlayer, 100)