-- ZoneController.lua

local ZoneController = {}

-- Initialize stability settings
ZoneController.stabilityThreshold = 70
ZoneController.currentStability = 100

-- Function to manage zone stability
function ZoneController:manageZoneStability(stabilityChange)
    self.currentStability = self.currentStability + stabilityChange
    if self.currentStability < 0 then
        self.currentStability = 0
        print("Zone stability depleted!")
    elseif self.currentStability > 100 then
        self.currentStability = 100
    end
    self:checkStability()
end

-- Function to check zone stability
function ZoneController:checkStability()
    if self.currentStability < self.stabilityThreshold then
        print("Warning: Zone stability is low!")
    else
        print("Zone stability is stable.")
    end
end

return ZoneController