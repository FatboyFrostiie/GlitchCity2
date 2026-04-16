local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local IslandsConfig = require(game.ServerScriptService.Config.Islands)
local BossesConfig = require(game.ServerScriptService.Config.Bosses)
local ShockwaveModule = require(game.ServerScriptService.EnemyAI.ShockwaveModule)

local BossController = {}

local function createBossModel(islandName, bossCfg, neonColor)
    local model = Instance.new("Model")
    model.Name = islandName .. "_Boss"

    local core = Instance.new("Part")
    core.Name = "Core"
    core.Size = Vector3.new(20, 20, 20)
    core.Material = Enum.Material.Neon
    core.Color = neonColor
    core.Anchored = true
    core.CanCollide = false
    core.Parent = model

    local hum = Instance.new("Humanoid")
    hum.MaxHealth = bossCfg.MaxHealth
    hum.Health = bossCfg.MaxHealth
    hum.Parent = model

    local light = Instance.new("PointLight")
    light.Color = neonColor
    light.Range = 120
    light.Brightness = 5
    light.Parent = core

    return model, core, hum
end

local function randomBossPoint(island, radius, heightOffset)
    local angle = math.random() * math.pi * 2
    local r = math.random() * radius
    local x = island.Position.X + math.cos(angle) * r
    local z = island.Position.Z + math.sin(angle) * r
    local y = island.Position.Y + heightOffset
    return Vector3.new(x, y, z)
end

local function findNearestPlayer(pos, range)
    local nearest, nearestDist = nil, nil

    for _, player in ipairs(Players:GetPlayers()) do
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")

        if hrp then
            local dist = (hrp.Position - pos).Magnitude
            if dist <= range and (not nearestDist or dist < nearestDist) then
                nearest = hrp
                nearestDist = dist
            end
        end
    end

    return nearest, nearestDist
end

function BossController.SpawnBosses(cityFolder)
    local bossesFolder = Instance.new("Folder")
    bossesFolder.Name = "Bosses"
    bossesFolder.Parent = cityFolder

    for _, island in ipairs(IslandsConfig.Islands) do
        local bossCfg = BossesConfig[island.Name]
        if bossCfg then
            local model, core, hum =
                createBossModel(island.Name, bossCfg, island.NeonColor)

            model.Parent = bossesFolder

            local heightOffset = 40
            if bossCfg.MoveStyle == "FloatDash" then
                heightOffset = 80
            elseif bossCfg.MoveStyle == "HoverSweep" then
                heightOffset = 100
            end

            core.Position = randomBossPoint(island, island.Radius * 0.5, heightOffset)

            local state = {
                Island = island,
                Config = bossCfg,
                Core = core,
                Humanoid = hum,
                Aggro = false,
                AggroTarget = nil,
                TargetPos = randomBossPoint(island, island.Radius * 0.6, heightOffset),
                LastShockwave = 0,
                ShockwaveCooldown = 3,
                HeightOffset = heightOffset,
            }

            hum.HealthChanged:Connect(function(newHealth)
                if newHealth < hum.MaxHealth then
                    state.Aggro = true
                end
            end)

            task.spawn(function()
                while core.Parent and hum.Health > 0 do
                    local dt = RunService.Heartbeat:Wait()
                    local pos = core.Position

                    if state.Aggro then
                        local target, dist =
                            findNearestPlayer(pos, 260)

                        if target then
                            state.AggroTarget = target

                            if state.Config.MoveStyle == "FloatDash" then
                                local desired = target.Position + Vector3.new(0, state.HeightOffset, 0)
                                local dir = (desired - pos)
                                local mag = dir.Magnitude
                                if mag > 5 then
                                    local step = dir.Unit * 40 * dt
                                    core.Position = pos + step
                                end

                            elseif state.Config.MoveStyle == "Charge" then
                                local dir = (target.Position - pos)
                                local mag = dir.Magnitude
                                if mag > 5 then
                                    local step = dir.Unit * 32 * dt
                                    core.Position = pos + step
                                end

                            elseif state.Config.MoveStyle == "HoverSweep" then
                                local desired = target.Position + Vector3.new(0, state.HeightOffset, 0)
                                local dir = (desired - pos)
                                local mag = dir.Magnitude
                                if mag > 5 then
                                    local step = dir.Unit * 36 * dt
                                    core.Position = pos + step
                                end

                            elseif state.Config.MoveStyle == "Teleport" then
                                if math.random() < 0.02 then
                                    core.Position = target.Position + Vector3.new(
                                        math.random(-20, 20),
                                        state.HeightOffset,
                                        math.random(-20, 20)
                                    )
                                end

                            elseif state.Config.MoveStyle == "Phase" then
                                if math.random() < 0.03 then
                                    core.Transparency = 1
                                    task.wait(0.1)
                                    core.Transparency = 0
                                    core.Position = target.Position + Vector3.new(
                                        math.random(-15, 15),
                                        state.HeightOffset,
                                        math.random(-15, 15)
                                    )
                                end
                            end

                            if tick() - state.LastShockwave > state.ShockwaveCooldown then
                                state.LastShockwave = tick()
                                ShockwaveModule.EmitShockwave(
                                    core,
                                    state.Config.ShockwaveRadius,
                                    0.3
                                )
                            end
                        else
                            state.Aggro = false
                            state.AggroTarget = nil
                        end

                    else
                        local dir = (state.TargetPos - pos)
                        local dist = dir.Magnitude

                        if dist < 10 then
                            state.TargetPos =
                                randomBossPoint(island, island.Radius * 0.6, state.HeightOffset)
                        else
                            local step = dir.Unit * 18 * dt
                            core.Position = pos + step
                        end
                    end
                end
            end)
        end
    end
end

return BossController
