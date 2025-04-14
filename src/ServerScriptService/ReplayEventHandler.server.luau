local replicatedStorage = game:GetService("ReplicatedStorage")
local replayEvent = replicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RemoteEvent_Replay")

local function ResetGame()
    replayEvent:FireAllClients("Hide")
    print("Resetting game...")
end

replayEvent.OnServerEvent:Connect(function(player)
    print("Replay event triggered by player: " .. player.Name)
    ResetGame()
end)