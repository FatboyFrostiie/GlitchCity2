local TweenService = game:GetService("TweenService")

local NeonUITransitions = {}

function NeonUITransitions.FadeIn(gui)
    gui.Visible = true
    gui.BackgroundTransparency = 1

    TweenService:Create(gui, TweenInfo.new(0.25), {
        BackgroundTransparency = 0
    }):Play()
end

function NeonUITransitions.FadeOut(gui)
    TweenService:Create(gui, TweenInfo.new(0.25), {
        BackgroundTransparency = 1
    }):Play()

    task.delay(0.3, function()
        gui.Visible = false
    end)
end

function NeonUITransitions.SlideIn(frame)
    local orig = frame.Position
    frame.Position = orig + UDim2.new(0, 0, 0.1, 0)

    TweenService:Create(frame, TweenInfo.new(0.25), {
        Position = orig
    }):Play()
end

return NeonUITransitions
