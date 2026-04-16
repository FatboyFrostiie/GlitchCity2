local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local Remotes = ReplicatedStorage:FindFirstChild("Remotes") or Instance.new("Folder", ReplicatedStorage)
Remotes.Name = "Remotes"

local AbilityRemote = Remotes:FindFirstChild("UseAbility") or Instance.new("RemoteEvent", Remotes)
AbilityRemote.Name = "UseAbility"

local function useAbility(slotIndex)
    AbilityRemote:FireServer(slotIndex)
end

local function bindKeyToSlot(actionName, inputState, inputObj, slotIndex)
    if inputState ~= Enum.UserInputState.Begin then return end
    useAbility(slotIndex)
end

ContextActionService:BindAction("Ability_Q", function(a,s,i) bindKeyToSlot(a,s,i,1) end, false, Enum.KeyCode.Q)
ContextActionService:BindAction("Ability_E", function(a,s,i) bindKeyToSlot(a,s,i,2) end, false, Enum.KeyCode.E)
ContextActionService:BindAction("Ability_R", function(a,s,i) bindKeyToSlot(a,s,i,3) end, false, Enum.KeyCode.R)
ContextActionService:BindAction("Ability_F", function(a,s,i) bindKeyToSlot(a,s,i,4) end, false, Enum.KeyCode.F)

-- Counter: Right mouse / LB
ContextActionService:BindAction("Ability_Counter", function(actionName, inputState, inputObj)
    if inputState ~= Enum.UserInputState.Begin then return end
    AbilityRemote:FireServer("Counter")
end, false, Enum.UserInputType.MouseButton2, Enum.KeyCode.ButtonL1)
