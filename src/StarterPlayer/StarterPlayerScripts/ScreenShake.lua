local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local cam = workspace.CurrentCamera

local ScreenShake = {}

local shakePower = 0

function ScreenShake.Shake(power, duration)
    shakePower = power
    task.delay(duration, function()
        shakePower = 0
    end)
end

RunService.RenderStepped:Connect(function()
    if shakePower > 0 then
        cam.CFrame = cam.CFrame * CFrame.new(
            (math.random() - 0.5) * shakePower,
            (math.random() - 0.5) * shakePower,
            0
        )
    end
end)

return ScreenShake
