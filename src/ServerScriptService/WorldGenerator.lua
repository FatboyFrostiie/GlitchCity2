local Workspace = game:GetService("Workspace")
local ServerScriptService = game:GetService("ServerScriptService")

local IslandsConfig = require(ServerScriptService.Config.Islands)
local WeatherController = require(ServerScriptService.Weather.WeatherController)
local DroneController = require(ServerScriptService.EnemyAI.DroneController)
local EnemyController = require(ServerScriptService.EnemyAI.EnemyController)
local BossController = require(ServerScriptService.EnemyAI.BossController)

local WATER_HEIGHT = IslandsConfig.WATER_HEIGHT

local function createPart(props)
    local p = Instance.new("Part")
    p.Anchored = true
    p.Material = props.Material or Enum.Material.SmoothPlastic
    p.Color = props.Color or Color3.new(1,1,1)
    p.Size = props.Size or Vector3.new(10,10,10)
    p.Position = props.Position or Vector3.new(0,0,0)
    p.Parent = props.Parent
    p.Name = props.Name or "Part"
    p.TopSurface = Enum.SurfaceType.Smooth
    p.BottomSurface = Enum.SurfaceType.Smooth
    if props.Transparency then p.Transparency = props.Transparency end
    if props.CanCollide ~= nil then p.CanCollide = props.CanCollide end
    return p
end

local function neonLight(parent, color, range, brightness)
    local l = Instance.new("PointLight")
    l.Color = color
    l.Range = range
    l.Brightness = brightness
    l.Parent = parent
end

local function createOcean(parent)
    createPart({
        Name = "Ocean",
        Parent = parent,
        Material = Enum.Material.Water,
        Color = Color3.fromRGB(5, 15, 30),
        Size = Vector3.new(6000, 300, 6000),
        Position = Vector3.new(0, WATER_HEIGHT - 150, 0),
        CanCollide = false
    })
end

local function createIslandBase(parent, island)
    createPart({
        Name = island.Name .. "_Base",
        Parent = parent,
        Material = Enum.Material.Rock,
        Color = Color3.fromRGB(15, 15, 20),
        Size = Vector3.new(IslandsConfig.ISLAND_RADIUS * 2, 40, IslandsConfig.ISLAND_RADIUS * 2),
        Position = island.Position
    })
end

local function createSkyscraper(parent, pos, neonColor)
    local h = math.random(80, 250)
    local w = math.random(30, 50)
    local d = math.random(30, 50)

    local tower = createPart({
        Name = "Tower",
        Parent = parent,
        Material = Enum.Material.Metal,
        Color = Color3.fromRGB(25,25,30),
        Size = Vector3.new(w, h, d),
        Position = pos + Vector3.new(0, h/2, 0)
    })

    local offsets = {
        Vector3.new(w/2,0,d/2),
        Vector3.new(-w/2,0,d/2),
        Vector3.new(w/2,0,-d/2),
        Vector3.new(-w/2,0,-d/2),
    }

    for _,off in ipairs(offsets) do
        local strip = createPart({
            Name = "NeonStrip",
            Parent = tower,
            Material = Enum.Material.Neon,
            Color = neonColor,
            Size = Vector3.new(1, h, 1),
            Position = tower.Position + off
        })
        neonLight(strip, neonColor, 25, 2.5)
    end
end

local function createPond(parent, pos, radius)
    createPart({
        Name = "Pond",
        Parent = parent,
        Material = Enum.Material.Water,
        Color = Color3.fromRGB(10, 30, 50),
        Size = Vector3.new(radius*2, 20, radius*2),
        Position = pos + Vector3.new(0, WATER_HEIGHT - 10, 0),
        CanCollide = false
    })
end

local function createBridge(parent, a, b, color)
    local dir = b - a
    local len = dir.Magnitude
    local mid = a + dir/2

    local base = createPart({
        Name = "Bridge",
        Parent = parent,
        Material = Enum.Material.Metal,
        Color = Color3.fromRGB(30,30,35),
        Size = Vector3.new(18, 2, len),
        Position = Vector3.new(mid.X, WATER_HEIGHT + 20, mid.Z)
    })

    base.CFrame = CFrame.new(base.Position, base.Position + Vector3.new(dir.X,0,dir.Z))

    for _,side in ipairs({-1,1}) do
        local rail = createPart({
            Name = "Rail",
            Parent = parent,
            Material = Enum.Material.Neon,
            Color = color,
            Size = Vector3.new(1, 3, len),
            Position = base.Position + base.CFrame.RightVector * (side * 9)
        })
        rail.CFrame = base.CFrame
        neonLight(rail, color, 30, 3)
    end
end

local function createOceanRuins(parent)
    local folder = Instance.new("Folder")
    folder.Name = "OceanRuins"
    folder.Parent = parent

    for i=1,30 do
        local x = math.random(-2500,2500)
        local z = math.random(-2500,2500)

        if math.abs(x) > 600 or math.abs(z) > 600 then
            createPart({
                Name = "BrokenTower",
                Parent = folder,
                Material = Enum.Material.Metal,
                Color = Color3.fromRGB(30,30,35),
                Size = Vector3.new(40, math.random(40,120), 40),
                Position = Vector3.new(x, WATER_HEIGHT + math.random(-20,40), z)
            })
        end
    end
end

local function createSpawn(cityFolder)
    local spawn = Instance.new("SpawnLocation")
    spawn.Size = Vector3.new(6,1,6)
    spawn.Position = Vector3.new(0, WATER_HEIGHT + 60, 0)
    spawn.Anchored = true
    spawn.Parent = cityFolder
end

local function main()
    if Workspace:FindFirstChild("GlitchCity") then
        Workspace.GlitchCity:Destroy()
    end

    local city = Instance.new("Folder")
    city.Name = "GlitchCity"
    city.Parent = Workspace

    createOcean(city)

    local islandsFolder = Instance.new("Folder")
    islandsFolder.Name = "Islands"
    islandsFolder.Parent = city

    local anchors = {}

    for _, island in ipairs(IslandsConfig.Islands) do
        local folder = Instance.new("Folder")
        folder.Name = island.Name
        folder.Parent = islandsFolder

        createIslandBase(folder, island)

        for i=1,5 do
            local offset = Vector3.new(
                math.random(-120,120),
                0,
                math.random(-120,120)
            )
            createSkyscraper(folder, island.Position + offset, island.NeonColor)
        end

        for i=1,3 do
            local offset = Vector3.new(
                math.random(-150,150),
                0,
                math.random(-150,150)
            )
            createPond(folder, island.Position + offset, math.random(20,40))
        end

        local dir = (Vector3.new(0, island.Position.Y, 0) - island.Position).Unit
        anchors[island.Name] = island.Position + dir * IslandsConfig.ISLAND_RADIUS
    end

    local bridgesFolder = Instance.new("Folder")
    bridgesFolder.Name = "Bridges"
    bridgesFolder.Parent = city

    local function connect(a,b,color)
        createBridge(bridgesFolder, anchors[a], anchors[b], color)
    end

    connect("NeonCore","IndustrialSector",Color3.fromRGB(0,255,255))
    connect("IndustrialSector","SkyDistrict",Color3.fromRGB(255,140,0))
    connect("SkyDistrict","GlitchWasteland",Color3.fromRGB(0,120,255))
    connect("GlitchWasteland","DataTunnels",Color3.fromRGB(180,0,255))
    connect("DataTunnels","NeonCore",Color3.fromRGB(0,255,0))

    createOceanRuins(city)
    createSpawn(city)

    WeatherController.Init()
    DroneController.SpawnDrones(city)
    EnemyController.SpawnEnemies(city)
    BossController.SpawnBosses(city)

    print("Glitch City — Cinematic Modular Build Loaded.")
end

main()
