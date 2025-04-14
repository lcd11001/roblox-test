local gui: ScreenGui = script.Parent

local replicatedStorage = game:GetService("ReplicatedStorage")
local replayEvent = replicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RemoteEvent_Replay")

local function ShowHide(action)
	if action == "Hide" then
		gui.Enabled = false
	end

	if action == "Show" then
		gui.Enabled = true
	end
end

replayEvent.OnClientEvent:Connect(ShowHide)
