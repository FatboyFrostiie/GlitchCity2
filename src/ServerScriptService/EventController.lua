-- EventController.lua

-- This is a simple event system for managing custom events in Roblox.

local EventController = {}
EventController.__index = EventController

function EventController.new()
    local self = setmetatable({}, EventController)
    self.events = {}
    return self
end

function EventController:registerEvent(eventName)
    if not self.events[eventName] then
        self.events[eventName] = {}
    end
end

function EventController:subscribe(eventName, callback)
    if self.events[eventName] then
        table.insert(self.events[eventName], callback)
    end
end

function EventController:emit(eventName, ...)
    if self.events[eventName] then
        for _, callback in ipairs(self.events[eventName]) do
            callback(...) -- Call each callback with the provided arguments.
        end
    end
end

return EventController
