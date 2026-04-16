-- DataService.lua

local DataService = {}

local playerData = {} -- Table to hold player data

-- Function to initialize player data
function DataService:initPlayerData(playerId)
    playerData[playerId] = {
        xp = 0, -- Experience Points
        fragments = 0 -- Fragments collected by the player
    }
end

-- Function to add experience points to a player
function DataService:addXP(playerId, amount)
    if playerData[playerId] then
        playerData[playerId].xp = playerData[playerId].xp + amount
        return playerData[playerId].xp
    end
    return nil -- Player not found
end

-- Function to add fragments to a player
function DataService:addFragments(playerId, amount)
    if playerData[playerId] then
        playerData[playerId].fragments = playerData[playerId].fragments + amount
        return playerData[playerId].fragments
    end
    return nil -- Player not found
end

-- Function to get player data
function DataService:getPlayerData(playerId)
    return playerData[playerId] or nil -- Return player data or nil if not found
end

return DataService