-- QuestController.lua

local QuestController = {}

-- Table to hold quest progression
QuestController.questProgress = {}

-- Function to start a new quest
function QuestController:startQuest(questId)
    if not self.questProgress[questId] then
        self.questProgress[questId] = {completed = false}
        print("Quest " .. questId .. " started.")
    else
        print("Quest " .. questId .. " is already in progress.")
    end
end

-- Function to complete a quest
function QuestController:completeQuest(questId)
    if self.questProgress[questId] and not self.questProgress[questId].completed then
        self.questProgress[questId].completed = true
        print("Quest " .. questId .. " completed.")
    else
        print("Quest " .. questId .. " was not started or already completed.")
    end
end

-- Function to check quest status
function QuestController:getQuestStatus(questId)
    if self.questProgress[questId] then
        return self.questProgress[questId].completed and "Completed" or "In Progress"
    else
        return "Quest not started."
    end
end

return QuestController
