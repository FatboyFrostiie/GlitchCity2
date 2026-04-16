local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local AttackRemote = Remotes:WaitForChild("WeaponAttack")

local WeaponService = require(ReplicatedStorage.Modules.WeaponService)

local currentWeaponId = "Fists"
local canAttack = true

local function getCharacter()
    return player.Character or player.CharacterAdded:Wait()
end

local function getRoot()
    local char = getCharacter()
    return char:WaitForChild("HumanoidRootPart")
end

local function playSwingEffect(weaponId)
    -- You can add trails, neon flashes, etc. here
end

local function attack()
    if not canAttack then return end
    local weaponData = WeaponService.GetWeaponData(currentWeaponId)
    if not weaponData then return end

    canAttack = false
    local root = getRoot()
    local originCFrame = root.CFrame

    playSwingEffect(currentWeaponId)
    AttackRemote:FireServer(currentWeaponId, originCFrame)

    task.delay(weaponData.Cooldown or 0.4, function()
        canAttack = true
    end)
end

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        attack()
    end
end)

-- Hotbar will update currentWeaponId via a BindableEvent
local HotbarEvent = Instance.new("BindableEvent")
HotbarEvent.Name = "HotbarWeaponChanged"
HotbarEvent.Parent = script

function HotbarEvent.OnInvoke(newWeaponId)
    currentWeaponId = newWeaponId
end

script:SetAttribute("HotbarEventName", HotbarEvent.Name)
