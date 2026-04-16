local QuestService = {}

QuestService.Quests = {
    StabilizeNeonCore = {
        Id = "StabilizeNeonCore",
        Name = "Stabilize Neon Core",
        Description = "Increase stability in Neon Core by 50.",
        ZoneId = "NeonCore",
        RequiredStabilityGain = 50,
        RewardXP = 100,
        RewardFragments = 10,
    },

    DroneCleanup = {
        Id = "DroneCleanup",
        Name = "Drone Cleanup",
        Description = "Defeat 10 Corrupted Drones.",
        EnemyId = "CorruptedDrone",
        RequiredKills = 10,
        RewardXP = 150,
        RewardFragments = 15,
    },
}

function QuestService:GetStarterQuests()
    return {
        QuestService.Quests.StabilizeNeonCore,
        QuestService.Quests.DroneCleanup,
    }
end

return QuestService