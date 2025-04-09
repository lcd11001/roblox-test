local replicatedStorage = game:GetService("ReplicatedStorage")
local Helper = require(replicatedStorage:WaitForChild("Helper"))

local remoteEvent: RemoteEvent = Helper.WaitObjectByPath("ReplicatedStorage/RemoteEvents/RemoteEvent_Hello")

local function FromTheClient(player)
    local leaderstats = player:WaitForChild("leaderstats")
    local score = leaderstats:WaitForChild("Score")
    score.Value += 1

    if score.Value >= 5 then
        remoteEvent:FireClient(player, "HideUI")
    end
end

remoteEvent.OnServerEvent:Connect(FromTheClient)
