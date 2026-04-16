local EnemySpawner = {}

EnemySpawner.enemies = {}
EnemySpawner.spawnRate = 5  -- Time in seconds between spawns
EnemySpawner.spawnArea = Vector3.new(100, 0, 100)  -- Example spawn area dimensions

function EnemySpawner:spawnEnemy()
    local enemy = Instance.new("Part")  -- Example enemy creation, replace with actual enemy logic
    enemy.Size = Vector3.new(1, 1, 1)
    enemy.Position = Vector3.new(math.random(-self.spawnArea.X/2, self.spawnArea.X/2), 0, math.random(-self.spawnArea.Z/2, self.spawnArea.Z/2))
    enemy.Parent = workspace  -- Adjust parenting according to game structure

    table.insert(self.enemies, enemy)
end

function EnemySpawner:startSpawning()
    while true do
        wait(self.spawnRate)  -- Wait for the specified spawn rate
        self:spawnEnemy()  -- Call the spawn function
    end
end

return EnemySpawner
