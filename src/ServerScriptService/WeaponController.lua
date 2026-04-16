local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local WeaponService = require(ReplicatedStorage.Modules.WeaponService)

local RemotesFolder = ReplicatedStorage:FindFirstChild("Remotes") or Instance.new("Folder", ReplicatedStorage)
RemotesFolder.Name = "Remotes"

local AttackRemote = RemotesFolder:FindFirstChild("WeaponAttack") or Instance.new("RemoteEvent", RemotesFolder)
AttackRemote.Name = "WeaponAttack"

local playerDataStore = {} -- You will wire this into your real data system

local function getPlayerData(player)
    playerDataStore[player] = playerDataStore[player] or {
        Weapons = WeaponService.GetDefaultInventory().Weapons,
        EquippedWeapon = "Fists",
    }
    return playerDataStore[player]
end

local function applyDamage(hitHumanoid, damage)
    if not hitHumanoid or not hitHumanoid.Health or hitHumanoid.Health <= 0 then return end
    hitHumanoid:TakeDamage(damage)
end

local function performHybridMelee(player, weaponId, originCFrame)
    local weaponData = WeaponService.GetWeaponData(weaponId)
    if not weaponData then return end

    local range = weaponData.Range or 7
    local damage = weaponData.Damage or 10

    -- Raycast forward
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {player.Character}
    params.FilterType = Enum.RaycastFilterType.Blacklist

    local dir = originCFrame.LookVector * range
    local result = workspace:Raycast(originCFrame.Position, dir, params)

    if result and result.Instance then
        local hum = result.Instance.Parent:FindFirstChildOfClass("Humanoid")
        if not hum and result.Instance.Parent.Parent then
            hum = result.Instance.Parent.Parent:FindFirstChildOfClass("Humanoid")
        end
        if hum then
            applyDamage(hum, damage)
            return
        end
    end

    -- Hitbox sphere as backup
    local region = Region3.new(
        originCFrame.Position - Vector3.new(range, range, range),
        originCFrame.Position + Vector3.new(range, range, range)
    )

    local parts = workspace:FindPartsInRegion3WithIgnoreList(region, {player.Character}, 50)
    for _, part in ipairs(parts) do
        local hum = part.Parent:FindFirstChildOfClass("Humanoid")
        if not hum and part.Parent.Parent then
            hum = part.Parent.Parent:FindFirstChildOfClass("Humanoid")
        end
        if hum then
            applyDamage(hum, damage)
            break
        end
    end
end

AttackRemote.OnServerEvent:Connect(function(player, weaponId, originCFrame)
    local data = getPlayerData(player)
    if data.EquippedWeapon ~= weaponId then return end
    if not player.Character then return end

    performHybridMelee(player, weaponId, originCFrame)
end)

Players.PlayerRemoving:Connect(function(player)
    playerDataStore[player] = nil
end)
