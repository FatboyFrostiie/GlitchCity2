local QuestSystem = {}

QuestSystem.Quests = {
    Kill10Enemies = {
        Id = "Kill10Enemies",
        Name = "First Blood",
        Description = "Defeat 10 enemies.",
        Type = "Kill",
        Target = "Enemy",
        Required = 10,
        RewardXP = 500,
        RewardFragments = 5,
    },
}

function QuestSystem.CreateState()
    return {
        Active = {},
        Completed = {},
    }
end

function QuestSystem.StartQuest(state, questId)
    if state.Completed[questId] then return end
    state.Active[questId] = {Progress = 0}
end

function QuestSystem.OnKill(state, enemyType)
    for id, quest in pairs(QuestSystem.Quests) do
        local qState = state.Active[id]
        if qState and quest.Type == "Kill" then
            qState.Progress += 1
        end
    end
end

function QuestSystem.CheckComplete(state)
    local completed = {}
    for id, quest in pairs(QuestSystem.Quests) do
        local qState = state.Active[id]
        if qState and qState.Progress >= quest.Required then
            state.Completed[id] = true
            state.Active[id] = nil
            table.insert(completed, quest)
        end
    end
    return completed
end

return QuestSystem
