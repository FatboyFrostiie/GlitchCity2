local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local HotbarService = require(ReplicatedStorage.Modules.HotbarService)
local WeaponService = require(ReplicatedStorage.Modules.WeaponService)

local hotbar = HotbarService.GetDefaultHotbar()
local currentSlot = 1

local weaponClientScript = player:WaitForChild("PlayerScripts"):WaitForChild("WeaponClient")
local hotbarEventName = weaponClientScript:GetAttribute("HotbarEventName")
local hotbarEvent = weaponClientScript:FindFirstChild(hotbarEventName)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HotbarUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

local barFrame = Instance.new("Frame")
barFrame.Name = "Bar"
barFrame.AnchorPoint = Vector2.new(0.5, 1)
barFrame.Position = UDim2.new(0.5, 0, 1, -20)
barFrame.Size = UDim2.new(0, 400, 0, 60)
barFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
barFrame.BorderSizePixel = 0
barFrame.Parent = screenGui

local uiList = Instance.new("UIListLayout")
uiList.FillDirection = Enum.FillDirection.Horizontal
uiList.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiList.VerticalAlignment = Enum.VerticalAlignment.Center
uiList.Padding = UDim.new(0, 6)
uiList.Parent = barFrame

local slotButtons = {}

local function updateSlotVisual(slotIndex)
    for i, btn in ipairs(slotButtons) do
        if i == slotIndex then
            btn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
        else
            btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        end
    end
end

local function equipSlot(slotIndex)
    local weaponId = HotbarService.GetEquippedFromSlot(hotbar, slotIndex)
    if not weaponId then return end
    currentSlot = slotIndex
    updateSlotVisual(slotIndex)
    if hotbarEvent and hotbarEvent.Fire then
        hotbarEvent:Fire(weaponId)
    end
end

for i = 1, 4 do
    local btn = Instance.new("TextButton")
    btn.Name = "Slot" .. i
    btn.Size = UDim2.new(0, 80, 1, -10)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    btn.TextColor3 = Color3.fromRGB(200, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Text = tostring(i)
    btn.Parent = barFrame

    btn.MouseButton1Click:Connect(function()
        equipSlot(i)
    end)

    slotButtons[i] = btn
end

updateSlotVisual(currentSlot)
HotbarService.SetSlot(hotbar, 1, "Fists")
equipSlot(1)

local function onNumberKey(actionName, inputState, inputObj)
    if inputState ~= Enum.UserInputState.Begin then return end
    local num = tonumber(actionName:sub(-1))
    if num then
        equipSlot(num)
    end
end

for i = 1, 4 do
    ContextActionService:BindAction("Hotbar_" .. i, onNumberKey, false, Enum.KeyCode["One"] + (i - 1))
end

UserInputService.InputChanged:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType == Enum.UserInputType.MouseWheel then
        local dir = input.Position.Z > 0 and -1 or 1
        currentSlot = HotbarService.CycleSlot(currentSlot, dir)
        equipSlot(currentSlot)
    end
end)
