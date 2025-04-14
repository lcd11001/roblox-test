game.Players.PlayerAdded:Connect(function(player)
    -- create leaderstats folder
    -- and display all children of leaderstats into built-in Roblox leaderboard
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    -- create Score
    local score = Instance.new("IntValue")
    score.Name = "Score"
    score.Value = 0
    score.Parent = leaderstats

    -- create Attributes
    player:SetAttribute('HasLog', false)
    player:SetAttribute('HasFlint', false)
    player:SetAttribute('HasStone', false)
    player:SetAttribute('CanCarry', true)

    player:SetAttribute('AxeEquipped', false)
    player:SetAttribute('PickEquipped', false)
    player:SetAttribute('UsingAxe', false)
    player:SetAttribute('UsingPick', false)

    -- create player variables
    local playerVariables = Instance.new("Folder")
    playerVariables.Name = "PlayerVariables"
    playerVariables.Parent = player

    -- player level
    local playerLevel = Instance.new("IntValue")
    playerLevel.Name = "Level"
    playerLevel.Value = 1
    playerLevel.Parent = playerVariables

    -- player swings
    local playerSwings = Instance.new("IntValue")
    playerSwings.Name = "Swings"
    playerSwings.Value = 0
    playerSwings.Parent = playerVariables

end)