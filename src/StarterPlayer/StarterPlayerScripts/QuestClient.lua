-- QuestClient.lua

local Players = game:GetService("Players")
local StarterPlayerScripts = game:GetService("StarterPlayer")

local player = Players.LocalPlayer

local function notifyQuestCompletion(questName)
    -- Create a ScreenGui to show the notification
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local notificationFrame = Instance.new("Frame")
    notificationFrame.Size = UDim2.new(0.5, 0, 0.1, 0)
    notificationFrame.Position = UDim2.new(0.25, 0, 0.45, 0)
    notificationFrame.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    notificationFrame.Parent = screenGui

    local completionLabel = Instance.new("TextLabel")
    completionLabel.Size = UDim2.new(1, 0, 1, 0)
    completionLabel.Text = "Quest Completed: " .. questName
    completionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    completionLabel.BackgroundTransparency = 1
    completionLabel.Parent = notificationFrame

    -- Automatically remove the notification after 5 seconds
    wait(5)
    screenGui:Destroy()
end

-- Example usage (this would be triggered by your game's quest system)
-- notifyQuestCompletion("Find the Lost Artifact")

return {
    NotifyCompletion = notifyQuestCompletion
}