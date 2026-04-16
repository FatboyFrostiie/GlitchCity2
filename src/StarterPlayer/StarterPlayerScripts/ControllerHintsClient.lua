local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local PlayersService = game:GetService("Players")

local player = PlayersService.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local function setHintsVisible(visible)
    local abilityGui = PlayerGui:FindFirstChild("AbilityUI")
    if not abilityGui then return end

    local counter = abilityGui:FindFirstChild("CounterButton")
    if counter and counter:FindFirstChild("Hint") then
        counter.Hint.Visible = visible
    end
end

UserInputService.LastInputTypeChanged:Connect(function(inputType)
    local isController = inputType.Name:find("Gamepad") ~= nil
    setHintsVisible(isController)
end)

return true
