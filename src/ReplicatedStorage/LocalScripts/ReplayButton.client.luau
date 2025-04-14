local replicatedStorage = game:GetService("ReplicatedStorage")
local replayEvent = replicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RemoteEvent_Replay")

local button:TextButton = script.Parent

button.MouseButton1Click:Connect(function()
    replayEvent:FireServer()
end)