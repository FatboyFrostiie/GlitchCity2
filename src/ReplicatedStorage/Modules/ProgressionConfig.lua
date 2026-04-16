local ProgressionConfig = {}

ProgressionConfig.XPPerKill = 15
ProgressionConfig.XPPerBoss = 250
ProgressionConfig.XPPerQuest = 150
ProgressionConfig.XPPerChest = 40

ProgressionConfig.FragmentPerBoss = 3
ProgressionConfig.FragmentPerChest = 1

function ProgressionConfig.GetXPForLevel(level)
    if level == 1 then return 500 end
    if level == 2 then return 1000 end
    if level == 3 then return 2000 end
    if level == 4 then return 3500 end
    if level == 5 then return 5000 end
    if level == 6 then return 7000 end
    if level == 7 then return 9000 end
    if level == 8 then return 12000 end
    if level == 9 then return 15000 end
    return 15000 + (level - 9) * 3000
end

return ProgressionConfig
