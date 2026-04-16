local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local UIManager = {}

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local screens = {}

local function getScreen(name)
    if screens[name] then return screens[name] end
    local gui = PlayerGui:FindFirstChild(name)
    if gui then
        screens[name] = gui
        return gui
    end
end

local function fade(gui, visible)
    if not gui then return end
    gui.Enabled = true
    for _, obj in ipairs(gui:GetDescendants()) do
        if obj:IsA("Frame") or obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("ImageLabel") then
            if obj.BackgroundTransparency ~= nil then
                TweenService:Create(obj, TweenInfo.new(0.2), {
                    BackgroundTransparency = visible and 0 or 1
                }):Play()
            end
        end
    end
    if not visible then
        task.delay(0.25, function()
            gui.Enabled = false
        end)
    end
end

function UIManager.Show(name)
    local gui = getScreen(name)
    if gui then
        gui.Enabled = true
    end
end

function UIManager.Hide(name)
    local gui = getScreen(name)
    if gui then
        gui.Enabled = false
    end
end

function UIManager.Toggle(name)
    local gui = getScreen(name)
    if gui then
        gui.Enabled = not gui.Enabled
    end
end

return UIManager
