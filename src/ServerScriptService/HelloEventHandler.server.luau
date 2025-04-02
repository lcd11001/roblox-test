local replicatedStorage = game:GetService("ReplicatedStorage")
local Helper = require(replicatedStorage:WaitForChild("Helper"))

local remoteEvent = Helper.WaitObjectByPath("ReplicatedStorage/RemoteEvents/RemoteEvent_Hello")

local function FromTheClient(client)
	print("Hello " .. client.Name .. " from the server!")
end

remoteEvent.OnServerEvent:Connect(FromTheClient)
