print('TriggerPart script running')

local triggerPart = script.Parent
local debounce = true
local points = 10

triggerPart.Touched:Connect(function(otherPart)
    local character = otherPart.Parent
    local humanoid = character:FindFirstChild("Humanoid")

    -- reduce the number of times this function is called
    if humanoid and debounce then
        debounce = false
        -- print("Trigger touched by", otherPart:GetFullName())
        print("Update player score", character)

        -- Add points to the player
        local player = game.Players:GetPlayerFromCharacter(character)
        if player then
            -- player.leaderstats.Score.Value += points
            local pStats = player:WaitForChild("leaderstats")
            local pScore = pStats:WaitForChild("Score")
            pScore.Value += points
        end

        task.wait(1)
        debounce = true
    end
end)