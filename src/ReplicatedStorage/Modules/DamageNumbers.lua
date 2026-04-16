local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local DamageNumbers = {}

function DamageNumbers.Show(position, amount)
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(4, 0, 1, 0)
    billboard.Adornee = nil
    billboard.AlwaysOnTop = true
    billboard.Parent = workspace

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = tostring(amount)
    label.TextColor3 = Color3.fromRGB(0, 255, 170)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 32
    label.Parent = billboard

    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Adornee = workspace.Terrain
    billboard:SetPrimaryPartCFrame(CFrame.new(position))

    local tween = TweenService:Create(label, TweenInfo.new(0.6), {
        TextTransparency = 1,
        Position = UDim2.new(0, 0, -1, 0)
    })

    tween:Play()
    tween.Completed:Connect(function()
        billboard:Destroy()
    end)
end

return DamageNumbers
