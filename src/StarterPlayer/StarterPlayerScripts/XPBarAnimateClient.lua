local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local AbilityService = require(ReplicatedStorage.Modules.AbilityService)
local ProgressionConfig = require(ReplicatedStorage.Modules.ProgressionConfig)

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local XPRemote = Remotes:WaitForChild("AddAbilityXP")

local gui = PlayerGui:WaitForChild("AbilitySelectionUI")
local panel = gui.AbilityPanel
local xpBar = panel.XPBar
local xpFill = xpBar.Fill
local xpLabel = xpBar:FindFirstChildOfClass("TextLabel")

local state = AbilityService.GetDefaultAbilityData()

local function updateXPVisual()
    local level = state.Level
    local xp = state.XP
    local needed = ProgressionConfig.GetXPForLevel(level)

    local ratio = needed > 0 and math.clamp(xp / needed, 0, 1) or 0

    TweenService:Create(
        xpFill,
        TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(ratio, 0, 1, 0)}
    ):Play()

    xpLabel.Text = string.format("XP: %d / %d  (Lv %d)", xp, needed, level)
end

XPRemote.OnClientEvent:Connect(function(newLevel, newXP)
    state.Level = newLevel
    state.XP = newXP
    updateXPVisual()
end)

updateXPVisual()

return true
