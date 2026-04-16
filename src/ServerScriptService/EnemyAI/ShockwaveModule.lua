local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local ShockwaveModule = {}

-- Emits a safe neon shockwave that "tags" players without harming them.
function ShockwaveModule.EmitShockwave(originPart, radius, duration)
    if not originPart or not originPart.Parent then return end

    local startTime = tick()
    local tagged = {}

    task.spawn(function()
        while tick() - startTime < duration do
            for _, player in ipairs(Players:GetPlayers()) do
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChildOfClass("Humanoid")

                if hrp and hum and not tagged[player] then
                    local dist = (hrp.Position - originPart.Position).Magnitude
                    if dist <= radius then
                        tagged[player] = true

                        -- Safe "hit" — no damage, just a tag for client effects
                        hum:TakeDamage(0)

                        local tag = Instance.new("StringValue")
                        tag.Name = "ShockwaveHit"
                        tag.Parent = hum
                        game.Debris:AddItem(tag, 0.1)
                    end
                end
            end

            RunService.Heartbeat:Wait()
        end
    end)
end

return ShockwaveModule
