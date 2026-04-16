local TweenService = game:GetService("TweenService")

local EnemyReactions = {}

function EnemyReactions.Flash(model)
    for _, part in ipairs(model:GetDescendants()) do
        if part:IsA("BasePart") then
            local orig = part.Color
            part.Color = Color3.fromRGB(255, 80, 80)
            task.delay(0.1, function()
                part.Color = orig
            end)
        end
    end
end

function EnemyReactions.Knockback(humanoid, direction, force)
    local root = humanoid.Parent:FindFirstChild("HumanoidRootPart")
    if not root then return end
    root.Velocity = direction * force
end

function EnemyReactions.Stun(humanoid, duration)
    humanoid.WalkSpeed = 0
    humanoid.JumpPower = 0
    task.delay(duration, function()
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
    end)
end

return EnemyReactions
