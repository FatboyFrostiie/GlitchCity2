local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local function applyCameraShake()
    local cam = workspace.CurrentCamera
    if not cam then return end

    local originalCFrame = cam.CFrame
    local duration = 0.25
    local start = tick()

    task.spawn(function()
        while tick() - start < duration do
            local offset = Vector3.new(
                (math.random() - 0.5) * 0.4,
                (math.random() - 0.5) * 0.4,
                0
            )
            cam.CFrame = originalCFrame * CFrame.new(offset)
            RunService.RenderStepped:Wait()
        end

        cam.CFrame = originalCFrame
    end)
end

local function onHumanoidAdded(hum)
    hum.ChildAdded:Connect(function(child)
        if child.Name == "ShockwaveHit" then
            applyCameraShake()
        end
    end)
end

local function onCharacterAdded(char)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        onHumanoidAdded(hum)
    else
        char.ChildAdded:Connect(function(child)
            if child:IsA("Humanoid") then
                onHumanoidAdded(child)
            end
        end)
    end
end

if player.Character then
    onCharacterAdded(player.Character)
end

player.CharacterAdded:Connect(onCharacterAdded)
