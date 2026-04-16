local RunService = game:GetService("RunService")
local IslandsConfig = require(game.ServerScriptService.Config.Islands)
local DronesConfig = require(game.ServerScriptService.Config.Drones)

local DroneController = {}

local function createDroneModel(color)
    local model = Instance.new("Model")
    model.Name = "PatrolDrone"

    local core = Instance.new("Part")
    core.Name = "Core"
    core.Size = Vector3.new(4, 4, 4)
    core.Shape = Enum.PartType.Ball
    core.Material = Enum.Material.Neon
    core.Color = color
    core.Anchored = true
    core.CanCollide = false
    core.Parent = model

    local light = Instance.new("PointLight")
    light.Color = color
    light.Range = 40
    light.Brightness = 3
    light.Parent = core

    return model, core
end

local function randomCirclePoint(center, radius, height)
    local angle = math.random() * math.pi * 2
    local r = math.random() * radius
    local x = center.X + math.cos(angle) * r
    local z = center.Z + math.sin(angle) * r
    return Vector3.new(x, height, z)
end

function DroneController.SpawnDrones(cityFolder)
    local dronesFolder = Instance.new("Folder")
    dronesFolder.Name = "Drones"
    dronesFolder.Parent = cityFolder

    for _, island in ipairs(IslandsConfig.Islands) do
        local cfg = DronesConfig[island.Name]
        if cfg then
            for i = 1, cfg.Count do
                local model, core = createDroneModel(cfg.Color)
                model.Parent = dronesFolder

                local startPos = randomCirclePoint(
                    island.Position,
                    cfg.PatrolRadius,
                    island.Position.Y + cfg.Height
                )

                core.Position = startPos

                local state = {
                    Core = core,
                    Center = island.Position,
                    Radius = cfg.PatrolRadius,
                    Height = cfg.Height,
                    Speed = 18 + math.random() * 6,
                    Target = randomCirclePoint(
                        island.Position,
                        cfg.PatrolRadius,
                        island.Position.Y + cfg.Height
                    ),
                }

                task.spawn(function()
                    while core.Parent do
                        local dt = RunService.Heartbeat:Wait()
                        local pos = core.Position
                        local dir = (state.Target - pos)
                        local dist = dir.Magnitude

                        if dist < 5 then
                            state.Target = randomCirclePoint(
                                state.Center,
                                state.Radius,
                                state.Center.Y + state.Height
                            )
                        else
                            local step = dir.Unit * state.Speed * dt
                            core.Position = pos + step
                        end
                    end
                end)
            end
        end
    end
end

return DroneController
