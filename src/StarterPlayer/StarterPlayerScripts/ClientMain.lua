local ClientState = {}

function ClientState:new()
    local instance = setmetatable({}, { __index = self })
    instance.state = {}
    return instance
end

function ClientState:get(key)
    return self.state[key]
end

function ClientState:set(key, value)
    self.state[key] = value
end

function ClientState:subscribe(key, callback)
    if not self.subscribers then
        self.subscribers = {}
    end
    self.subscribers[key] = self.subscribers[key] or {}
    table.insert(self.subscribers[key], callback)
end

function ClientState:notify(key)
    if self.subscribers and self.subscribers[key] then
        for _, callback in ipairs(self.subscribers[key]) do
            callback(self.state[key])
        end
    end
end

return ClientState