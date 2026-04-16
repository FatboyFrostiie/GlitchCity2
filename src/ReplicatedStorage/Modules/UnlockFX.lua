local TweenService = game:GetService("TweenService")

local UnlockFX = {}

function UnlockFX.FlashFrame(frame, color)
    if not frame then return end
    local stroke = frame:FindFirstChildOfClass("UIStroke")
    if not stroke then
        stroke = Instance.new("UIStroke")
        stroke.Thickness = 2
        stroke.Color = color or Color3.fromRGB(0, 255, 170)
        stroke.Parent = frame
    end

    local tweenIn = TweenService:Create(stroke, TweenInfo.new(0.15), {Thickness = 6})
    local tweenOut = TweenService:Create(stroke, TweenInfo.new(0.25), {Thickness = 2})

    tweenIn:Play()
    tweenIn.Completed:Connect(function()
        tweenOut:Play()
    end)
end

function UnlockFX.PopupText(parentGui, text)
    if not parentGui then return end

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0, 300, 0, 40)
    label.AnchorPoint = Vector2.new(0.5, 0.5)
    label.Position = UDim2.new(0.5, 0, 0.2, 0)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(0, 255, 170)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 24
    label.Parent = parentGui

    local tweenIn = TweenService:Create(label, TweenInfo.new(0.2), {TextTransparency = 0})
    local tweenUp = TweenService:Create(label, TweenInfo.new(0.6), {Position = UDim2.new(0.5, 0, 0.15, 0)})
    local tweenOut = TweenService:Create(label, TweenInfo.new(0.3), {TextTransparency = 1})

    tweenIn:Play()
    tweenIn.Completed:Connect(function()
        tweenUp:Play()
        task.delay(0.4, function()
            tweenOut:Play()
            tweenOut.Completed:Connect(function()
                label:Destroy()
            end)
        end)
    end)
end

return UnlockFX
