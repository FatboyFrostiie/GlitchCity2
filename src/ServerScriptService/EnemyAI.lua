local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local ENEMY_FOLDER = workspace:WaitForChild("Enemies")

local function getClosestPlayer(pos, maxDist)
    local closest, dist = nil, maxDist or 100
    for _, plr in ipairs(Players:GetPlayers()) do
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local d = (hrp.Position - pos).Magnitude
            if d < dist then
                dist = d
                closest = plr
            end
        end
    end
    return closest
end

for _, enemy in ipairs(ENEMY_FOLDER:GetChildren()) do
    local hum = enemy:FindFirstChildOfClass("Humanoid")
    local root = enemy:FindFirstChild("HumanoidRootPart")
    if hum and root then
        task.spawn(function()
            while hum.Health > 0 do
                local target = getClosestPlayer(root.Position, 80)
                if target and target.Character then
                    local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hum:MoveTo(hrp.Position)
                    end
                end
                task.wait(0.5)
            end
        end)
    end
end
