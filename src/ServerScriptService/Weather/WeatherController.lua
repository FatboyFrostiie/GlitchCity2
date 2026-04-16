Weatherlocal Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local WeatherController = {}

function WeatherController.Init()
    -- Base cyberpunk lighting
    Lighting.Ambient = Color3.fromRGB(20, 20, 30)
    Lighting.OutdoorAmbient = Color3.fromRGB(10, 10, 20)
    Lighting.FogColor = Color3.fromRGB(10, 15, 25)
    Lighting.FogStart = 150
    Lighting.FogEnd = 1200
    Lighting.Brightness = 2

    -- Color correction for neon glow
    local colorCorrection = Instance.new("ColorCorrectionEffect")
    colorCorrection.Name = "GlitchCityColor"
    colorCorrection.TintColor = Color3.fromRGB(180, 200, 255)
    colorCorrection.Saturation = -0.1
    colorCorrection.Contrast = 0.1
    colorCorrection.Parent = Lighting

    -- Bloom for neon reflections
    local bloom = Instance.new("BloomEffect")
    bloom.Name = "GlitchCityBloom"
    bloom.Intensity = 1.2
    bloom.Size = 24
    bloom.Threshold = 1
    bloom.Parent = Lighting

    -- Fog pulsing loop
    task.spawn(function()
        while true do
            local t = tick() % 60
            local fogShift = math.sin(t / 60 * math.pi * 2) * 80

            Lighting.FogStart = 150 + fogShift
            Lighting.FogEnd = 1200 + fogShift * 2

            RunService.Heartbeat:Wait()
        end
    end)

    -- Occasional lightning flashes
    task.spawn(function()
        while true do
            task.wait(math.random(10, 25))

            local flash = Instance.new("ColorCorrectionEffect")
            flash.Name = "LightningFlash"
            flash.Brightness = 0.8
            flash.Contrast = 0.4
            flash.Parent = Lighting

            task.wait(0.15)
            flash:Destroy()
        end
    end)
end

return WeatherController
