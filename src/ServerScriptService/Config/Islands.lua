local WATER_HEIGHT = 100
local ISLAND_SPACING = 900
local ISLAND_RADIUS = 220

local Islands = {
    {
        Name = "NeonCore",
        Position = Vector3.new(0, WATER_HEIGHT + 20, 0),
        NeonColor = Color3.fromRGB(0, 255, 255),
        Radius = ISLAND_RADIUS
    },
    {
        Name = "IndustrialSector",
        Position = Vector3.new(ISLAND_SPACING, WATER_HEIGHT + 20, 0),
        NeonColor = Color3.fromRGB(255, 140, 0),
        Radius = ISLAND_RADIUS
    },
    {
        Name = "SkyDistrict",
        Position = Vector3.new(0, WATER_HEIGHT + 20, ISLAND_SPACING),
        NeonColor = Color3.fromRGB(0, 120, 255),
        Radius = ISLAND_RADIUS
    },
    {
        Name = "GlitchWasteland",
        Position = Vector3.new(-ISLAND_SPACING, WATER_HEIGHT + 20, 0),
        NeonColor = Color3.fromRGB(180, 0, 255),
        Radius = ISLAND_RADIUS
    },
    {
        Name = "DataTunnels",
        Position = Vector3.new(0, WATER_HEIGHT + 20, -ISLAND_SPACING),
        NeonColor = Color3.fromRGB(0, 255, 0),
        Radius = ISLAND_RADIUS
    },
}

return {
    WATER_HEIGHT = WATER_HEIGHT,
    ISLAND_SPACING = ISLAND_SPACING,
    ISLAND_RADIUS = ISLAND_RADIUS,
    Islands = Islands,
}
