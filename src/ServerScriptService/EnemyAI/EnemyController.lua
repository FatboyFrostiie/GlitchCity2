local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local IslandsConfig = require(game.ServerScriptService.Config.Islands)
local EnemiesConfig = require(game.ServerScriptService.Config.Enemies)
local ShockwaveModule = require(game.ServerScriptService.EnemyAI.ShockwaveModule)

local EnemyController = {}

local function createEnemyModel(enemyType, neonColor, maxHealth)
    local model = Instance.new("Model")
    model.Name = enemyType

    local core = Instance.new("Part")
    core.Name = "Core"
    core.Size = Vector3.new(6, 6, 6)
    core.Material = Enum.Material.Neon
    core.Color = neonColor
    core.Anchored = true
    core.CanCollide = false
    core.Parent = model

    local hum = Instance.new("Humanoid")
    hum.MaxHealth = maxHealth
    hum.Health = maxHealth
    hum.Parent = model

    local light = Instance.new("PointLight")
    light.Color = neonColor
    light.Range = 50
    light.Brightness = 3
    light.Parent = core

    return model, core, hum
end

local function randomPatrolPoint(island, radius)
    local angle = math.random() * math.pi * 2
    local r = math.random() * radius
    local x = island.Position.X + math.cos(angle) * r
    local z = island.Position.Z + math.sin(angle) * r
    local y = island.Position.Y + 5
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

function EnemyController.SpawnEnemies(cityFolder)
    local enemiesFolder = Instance.new("Folder")
    enemiesFolder.Name = "Enemies"
    enemiesFolder.Parent = cityFolder

    for _, island in ipairs(IslandsConfig.Islands) do
        local cfg = EnemiesConfig[island.Name]
        if cfg then
            for i = 1, cfg.Count do
                local model, core, hum =
                    createEnemyModel(cfg.Type, island.NeonColor, cfg.MaxHealth)

                model.Parent = enemiesFolder

                local startPos = randomPatrolPoint(island, cfg.PatrolRadius)
                core.Position = startPos

                local state = {
                    Island = island,
                    Config = cfg,
                    Core = core,
                    Humanoid = hum,
                    Mode = "Patrol",
                    TargetPos = randomPatrolPoint(island, cfg.PatrolRadius),
                    Aggro = false,
                    AggroTarget = nil,
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
                                findNearestPlayer(pos, state.Config.AggroRange)

                            if target then
                                state.AggroTarget = target
                                local dir = (target.Position - pos)
                                local mag = dir.Magnitude

                                if mag > 5 then
                                    local step = dir.Unit * 26 * dt
                                    core.Position = pos + step
                                end

                                if mag <= state.Config.ShockwaveRadius then
                                    ShockwaveModule.EmitShockwave(
                                        core,
                                        state.Config.ShockwaveRadius,
                                        0.2
                                    )
                                end
                            else
                                state.Aggro = false
                                state.AggroTarget = nil
                            end
                        else
                            local dir = (state.TargetPos - pos)
                            local dist = dir.Magnitude

                            if dist < 5 then
                                state.TargetPos =
                                    randomPatrolPoint(island, cfg.PatrolRadius)
                            else
                                local step = dir.Unit * 14 * dt
                                core.Position = pos + step
                            end
                        end
                    end
                end)
            end
        end
    end
end

return EnemyController
