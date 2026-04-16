local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
local ShopFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local BuyButton = Instance.new("TextButton")

-- Setting up the Shop UI
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ShopFrame.Parent = ScreenGui
ShopFrame.Size = UDim2.new(0.5, 0, 0.5, 0)
ShopFrame.Position = UDim2.new(0.25, 0, 0.25, 0)

TitleLabel.Parent = ShopFrame
TitleLabel.Size = UDim2.new(1, 0, 0.2, 0)
TitleLabel.Text = "Shop"
TitleLabel.TextScaled = true

BuyButton.Parent = ShopFrame
BuyButton.Size = UDim2.new(0.5, 0, 0.2, 0)
BuyButton.Position = UDim2.new(0.25, 0, 0.5, 0)
BuyButton.Text = "Purchase Item"
BuyButton.TextScaled = true

-- Purchase Functionality
local function onBuyButtonClick()
    -- Handle purchase request here
    print("Purchase Requested")
    -- You can add purchase logic here, such as server requests or data store interactions
end

BuyButton.MouseButton1Click:Connect(onBuyButtonClick)