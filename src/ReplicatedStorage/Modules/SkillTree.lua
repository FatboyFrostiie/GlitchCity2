local SkillTree = {}

SkillTree.Nodes = {
    MoreDamage = {
        Id = "MoreDamage",
        Name = "Increased Damage",
        Cost = 1,
        Requires = nil,
        Effect = {DamageMultiplier = 1.1},
    },
    MoreCooldown = {
        Id = "MoreCooldown",
        Name = "Reduced Cooldowns",
        Cost = 1,
        Requires = "MoreDamage",
        Effect = {CooldownMultiplier = 0.9},
    },
}

function SkillTree.CreateState()
    return {
        Points = 0,
        Unlocked = {},
    }
end

function SkillTree.CanUnlock(state, nodeId)
    local node = SkillTree.Nodes[nodeId]
    if not node then return false end
    if state.Unlocked[nodeId] then return false end
    if state.Points < node.Cost then return false end
    if node.Requires and not state.Unlocked[node.Requires] then return false end
    return true
end

function SkillTree.Unlock(state, nodeId)
    if not SkillTree.CanUnlock(state, nodeId) then return false end
    state.Points -= SkillTree.Nodes[nodeId].Cost
    state.Unlocked[nodeId] = true
    return true
end

return SkillTree
