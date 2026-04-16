local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NetworkFolder = ReplicatedStorage:FindFirstChild("Network")
if not NetworkFolder then
    NetworkFolder = Instance.new("Folder")
    NetworkFolder.Name = "Network"
    NetworkFolder.Parent = ReplicatedStorage
end

local function getOrCreate(name, className)
    local obj = NetworkFolder:FindFirstChild(name)
    if not obj then
        obj = Instance.new(className)
        obj.Name = name
        obj.Parent = NetworkFolder
    end
    return obj
end

local Network = {}

Network.Remotes = {
    AbilityRequest = getOrCreate("AbilityRequest", "RemoteEvent"),
    AbilityUpdate = getOrCreate("AbilityUpdate", "RemoteEvent"),
    XPUpdate = getOrCreate("XPUpdate", "RemoteEvent"),
    ZoneUpdate = getOrCreate("ZoneUpdate", "RemoteEvent"),
    FactionUpdate = getOrCreate("FactionUpdate", "RemoteEvent"),
    QuestUpdate = getOrCreate("QuestUpdate", "RemoteEvent"),
    QuestComplete = getOrCreate("QuestComplete", "RemoteEvent"),
    ShopItemsUpdate = getOrCreate("ShopItemsUpdate", "RemoteEvent"),
    ShopPurchaseRequest = getOrCreate("ShopPurchaseRequest", "RemoteEvent"),
    ShopPurchaseResult = getOrCreate("ShopPurchaseResult", "RemoteEvent"),
    EventUpdate = getOrCreate("EventUpdate", "RemoteEvent"),
}

return Network