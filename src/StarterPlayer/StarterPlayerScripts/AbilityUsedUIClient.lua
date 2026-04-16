local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local AbilityData = require(ReplicatedStorage.Modules.AbilityData)
local UnlockFX = require(ReplicatedStorage.Modules.UnlockFX)

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local AbilityUsedRemote = Remotes:WaitForChild("AbilityUsed")
local AbilityUnlockedRemote = Remotes:WaitForChild("AbilityUnlocked")

local gui = PlayerGui:WaitForChild("AbilityUI")
local cluster = gui:WaitForChild("AbilityCluster")

local slotFrames = {
    [1] = cluster.Slot1,
    [2] = cluster.Slot2,
    [3] = cluster.Slot3,
    [4] = cluster.Slot4,
}

local activeCooldowns = {}

local function setCooldown(slotIndex, duration)
    if type(slotIndex) ~= "number" then return end
    local now = tick()
    activeCooldowns[slotIndex] = {
        endTime = now + duration,
        duration = duration,
    }
end

AbilityUsedRemote.OnClientEvent:Connect(function(slotIndex, abilityId)
    if slotIndex == "Counter" then return end

    local data = AbilityData.GetAbility(abilityId)
    if not data or not data.Cooldown then return end

    setCooldown(slotIndex, data.Cooldown)
end)

AbilityUnlockedRemote.OnClientEvent:Connect(function(abilityId)
    UnlockFX.PopupText(PlayerGui, "NEW ABILITY UNLOCKED: " .. tostring(abilityId))
end)

RunService.RenderStepped:Connect(function()
    local now = tick()
    for slotIndex, cd in pairs(activeCooldowns) do
        local frame = slotFrames[slotIndex]
        if not frame then
            activeCooldowns[slotIndex] = nil
        else
            local overlay = frame:FindFirstChild("CooldownOverlay")
            if overlay then
                local remaining = cd.endTime - now
                if remaining <= 0 then
                    overlay.Visible = false
                    activeCooldowns[slotIndex] = nil
                else
                    overlay.Visible = true
                    local ratio = remaining / cd.duration
                    overlay.Size = UDim2.new(1, 0, ratio, 0)

                    local label = overlay:FindFirstChildOfClass("TextLabel")
                    if label then
                        label.Text = tostring(math.ceil(remaining))
                    end
                end
            end
        end
    end
end)
