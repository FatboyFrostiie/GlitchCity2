local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local gui = PlayerGui:WaitForChild("InventoryUI")
local grid = gui.MainPanel.WeaponGrid

local dragging = nil
local dragIcon = nil

local function createDragIcon(fromFrame)
    local icon = fromFrame:Clone()
    icon.Parent = gui
    icon.BackgroundTransparency = 0.3
    return icon
end

local function getSlotAtPosition(pos)
    for _, child in ipairs(grid:GetChildren()) do
        if child:IsA("Frame") then
            local absPos = child.AbsolutePosition
            local absSize = child.AbsoluteSize
            if pos.X >= absPos.X and pos.X <= absPos.X + absSize.X
            and pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y then
                return child
            end
        end
    end
end

for _, slot in ipairs(grid:GetChildren()) do
    if slot:IsA("Frame") then
        slot.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = slot
                dragIcon = createDragIcon(slot)
            end
        end)
    end
end

UserInputService.InputChanged:Connect(function(input)
    if dragging and dragIcon and input.UserInputType == Enum.UserInputType.MouseMovement then
        dragIcon.Position = UDim2.fromOffset(input.Position.X - dragIcon.AbsoluteSize.X / 2, input.Position.Y - dragIcon.AbsoluteSize.Y / 2)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and dragging then
        local target = getSlotAtPosition(input.Position)
        if target and target ~= dragging then
            -- Swap content (you’ll wire this to your inventory data)
            local temp = dragging:Clone()
            dragging:ClearAllChildren()
            for _, c in ipairs(target:GetChildren()) do c.Parent = dragging end

            target:ClearAllChildren()
            for _, c in ipairs(temp:GetChildren()) do c.Parent = target end
            temp:Destroy()
        end

        if dragIcon then dragIcon:Destroy() end
        dragging = nil
        dragIcon = nil
    end
end)
