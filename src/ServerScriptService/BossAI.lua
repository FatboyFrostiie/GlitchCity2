local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BossVFX = require(ReplicatedStorage.Modules.BossVFX)
local ScreenShake = nil -- client‑side, triggered via RemoteEvent

local Remotes = ReplicatedStorage:FindFirstChild("Remotes") or Instance.new("Folder", ReplicatedStorage)
Remotes.Name = "Remotes"

local BossCastRemote = Remotes:FindFirstChild("BossCast") or Instance.new("RemoteEvent", Remotes)
BossCastRemote.Name = "BossCast"

local BossModel = workspace:WaitForChild("Boss") -- your boss model
local Humanoid = BossModel:FindFirstChildOfClass("Humanoid")
local Root = BossModel:FindFirstChild("HumanoidRootPart")

local state = {
    Phase = 1,
    Target = nil,
    NextAttackTime = 0,
}

local function getClosestPlayer()
    local closest, dist = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local d = (hrp.Position - Root.Position).Magnitude
            if d < dist then
                dist = d
                closest = plr
            end
        end
    end
    return closest
end

local function doLaserAttack(target)
    if not target or not target.Character then return end
    local hrp = target.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local dir = (hrp.Position - Root.Position).Unit
    BossVFX.LaserBeam(Root.Position + Vector3.new(0, 5, 0), dir)
    BossCastRemote:FireAllClients("Laser", Root.Position, dir)
end

local function doGroundShatter()
    BossVFX.GroundShatter(Root.Position)
    BossCastRemote:FireAllClients("GroundShatter", Root.Position)
end

local function chooseAttack()
    if state.Phase == 1 then
        return math.random() < 0.6 and "Laser" or "GroundShatter"
    else
        return math.random() < 0.4 and "Laser" or "GroundShatter"
    end
end

RunService.Heartbeat:Connect(function(dt)
    if Humanoid.Health <= 0 then return end

    if not state.Target or not state.Target.Character then
        state.Target = getClosestPlayer()
    end

    if tick() >= state.NextAttackTime then
        local attack = chooseAttack()
        if attack == "Laser" then
            doLaserAttack(state.Target)
        elseif attack == "GroundShatter" then
            doGroundShatter()
        end
        state.NextAttackTime = tick() + 5
    end
end)
