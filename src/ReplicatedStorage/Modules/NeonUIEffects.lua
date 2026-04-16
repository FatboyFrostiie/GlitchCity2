local NeonUIEffects = {}

function NeonUIEffects.PulseStroke(stroke, speed, min, max)
    task.spawn(function()
        local t = 0
        while stroke.Parent do
            t += task.wait()
            local s = (math.sin(t * speed) + 1) / 2
            stroke.Thickness = min + (max - min) * s
        end
    end)
end

function NeonUIEffects.PulseGlow(imageLabel, speed, min, max)
    task.spawn(function()
        local t = 0
        while imageLabel.Parent do
            t += task.wait()
            local s = (math.sin(t * speed) + 1) / 2
            imageLabel.ImageTransparency = min + (max - min) * s
        end
    end)
end

function NeonUIEffects.HoverButton(button)
    local orig = button.BackgroundColor3
    local hover = Color3.fromRGB(0, 40, 40)

    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = hover
    end)

    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = orig
    end)
end

return NeonUIEffects
