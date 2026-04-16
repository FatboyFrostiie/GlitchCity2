--========================================================--
--  ABILITY CONTROLLER (FULL FILE REPLACEMENT)
--  Handles:
--   • Ability execution (Q/E/R/F)
--   • Counter (Right-click / LB)
--   • Double Jump
--   • Cooldowns
--   • XP gain hooks
--   • Unlock FX hooks
--========================================================--

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AbilityService = require(ReplicatedStorage.Modules.AbilityService)
local AbilityData = require(ReplicatedStorage.Modules.AbilityData)
local ProgressionConfig = require(ReplicatedStorage.Modules.ProgressionConfig)

--========================================================--
--  REMOTES
--========================================================--

local Remotes = ReplicatedStorage:FindFirstChild("Remotes") or Instance.new("Folder", ReplicatedStorage)
Remotes.Name = "Remotes"

local AbilityRemote = Remotes:FindFirstChild("UseAbility") or Instance.new("RemoteEvent", Remotes)
AbilityRemote.Name = "UseAbility"

local AbilityUsedRemote = Remotes:FindFirstChild("AbilityUsed") or Instance.new("RemoteEvent", Remotes)
AbilityUsedRemote.Name = "AbilityUsed"

local XPRemote = Remotes:FindFirstChild("AddAbilityXP") or Instance.new("RemoteEvent", Remotes)
XPRemote.Name = "AddAbilityXP"

local UnlockRemote = Remotes:FindFirstChild("AbilityUnlocked") or Instance.new("RemoteEvent", Remotes)
UnlockRemote.Name = "AbilityUnlocked"

local AbilityDamageRemote = Remotes:FindFirstChild("AbilityDamage") or Instance.new("RemoteEvent", Remotes)
AbilityDamageRemote.Name = "AbilityDamage"

--========================================================--
--  PLAYER ABILITY STATE
--========================================================--

local playerAbilityState = {}

local function getAbilityState(player)
    if not playerAbilityState[player] then
        playerAbilityState[player] = AbilityService.GetDefaultAbilityData()
    end
    return playerAbilityState[player]
end

--========================================================--
--  CHARACTER HELPERS
--========================================================--

local function getRoot(player)
    local char = player.Character
    if not char then return end
    return char:FindFirstChild("HumanoidRootPart"), char:FindFirstChildOfClass("Humanoid")
end

--========================================================--
--  DOUBLE JUMP
--========================================================--

local lastJump = {}

local function doDoubleJump(player)
    local root, hum = getRoot(player)
    if not root or not hum then return end

    local now = tick()
    if not lastJump[player] then lastJump[player] = 0 end

    if hum.FloorMaterial ~= Enum.Material.Air then
        lastJump[player] = now
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    else
        if now - lastJump[player] > 0.15 then
            root.Velocity = Vector3.new(root.Velocity.X, 60, root.Velocity.Z)
            lastJump[player] = now
        end
    end
end

--========================================================--
--  COUNTER
--========================================================--

local lastCounterUse = {}

local function doCounter(player)
    local now = tick()
    local counterData = AbilityData.GetAbility("Counter")
    local cd = counterData.Cooldown or 8

    if lastCounterUse[player] and now - lastCounterUse[player] < cd then
        return
    end

    lastCounterUse[player] = now

    -- Emit cooldown to client
    AbilityUsedRemote:FireClient(player, "Counter", "Counter")

    -- Parry window logic (hook into your combat system)
end

--========================================================--
--  COOLDOWN SYSTEM
--========================================================--

local lastAbilityUse = {}

local function canUseAbility(player, abilityId)
    local now = tick()
    lastAbilityUse[player] = lastAbilityUse[player] or {}
    local last = lastAbilityUse[player][abilityId] or 0

    local data = AbilityData.GetAbility(abilityId)
    if not data then return false end

    local cd = data.Cooldown or 5
    if now - last < cd then return false end

    lastAbilityUse[player][abilityId] = now
    return true
end

--========================================================--
--  ABILITY EXECUTION
--========================================================--

local function doAirStep(player)
    local root = getRoot(player)
    if not root then return end
    root.Velocity = root.CFrame.LookVector * 60 + Vector3.new(0, 20, 0)
end

local function doDash(player)
    local root = getRoot(player)
    if not root then return end
    root.Velocity = root.CFrame.LookVector * 80
end

local function doShockwaveBurst(player)
    -- FX handled on client
end

local function executeAbility(player, abilityId, slotIndex)
    local root = select(1, getRoot(player))

    if abilityId == "AirStep" then
        if not canUseAbility(player, "AirStep") then return end
        doAirStep(player)
        AbilityUsedRemote:FireClient(player, slotIndex, abilityId)

    elseif abilityId == "Dash" then
        if not canUseAbility(player, "Dash") then return end
        doDash(player)
        AbilityUsedRemote:FireClient(player, slotIndex, abilityId)

    elseif abilityId == "ShockwaveBurst" then
        if not canUseAbility(player, "ShockwaveBurst") then return end
        doShockwaveBurst(player)
        AbilityUsedRemote:FireClient(player, slotIndex, abilityId)

        if root then
            AbilityDamageRemote:FireServer(abilityId, root.CFrame)
        end
    end
end

--========================================================--
--  XP + UNLOCK HOOKS
--========================================================--

XPRemote.OnServerEvent:Connect(function(player, amount)
    local state = getAbilityState(player)
    AbilityService.AddXP(state, amount)

    -- Check unlocks
    for id, data in pairs(AbilityData.Abilities) do
        if data.UnlockLevel and state.Level >= data.UnlockLevel then
            if not state.UnlockedAbilities[id] then
                state.UnlockedAbilities[id] = true
                UnlockRemote:FireClient(player, id)
            end
        end
    end
end)

--========================================================--
--  MAIN REMOTE HANDLER
--========================================================--

AbilityRemote.OnServerEvent:Connect(function(player, slotOrId)
    local state = getAbilityState(player)

    -- Counter
    if slotOrId == "Counter" then
        doCounter(player)
        return
    end

    -- Ability slots (Q/E/R/F)
    local slotIndex = tonumber(slotOrId)
    if slotIndex then
        local abilityId = AbilityService.GetAbilityFromSlot(state, slotIndex)
        if abilityId then
            executeAbility(player, abilityId, slotIndex)
        end
    end
end)

--========================================================--
--  CLEANUP
--========================================================--

Players.PlayerRemoving:Connect(function(player)
    playerAbilityState[player] = nil
    lastCounterUse[player] = nil
    lastAbilityUse[player] = nil
    lastJump[player] = nil
end)
