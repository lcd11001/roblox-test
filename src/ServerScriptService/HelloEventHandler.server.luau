local replicatedStorage = game:GetService("ReplicatedStorage")
local Helper = require(replicatedStorage:WaitForChild("Helper"))

local remoteEvent = Helper.WaitObjectByPath("ReplicatedStorage/RemoteEvents/RemoteEvent_Hello")

local function FromTheClient(player)
	print("Hello " .. player.Name .. " from the server!")
    local leaderstats = player:WaitForChild("leaderstats")
    local score = leaderstats:WaitForChild("Score")
    score.Value += 1
end

remoteEvent.OnServerEvent:Connect(FromTheClient)
