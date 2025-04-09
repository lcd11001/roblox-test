local player: Player = game.Players.LocalPlayer
local button: TextButton = script.Parent
local label: TextLabel = button.Parent:WaitForChild("TextLabel")
local GUI:ScreenGui = script.Parent.Parent.Parent

local replicatedStorage = game:GetService("ReplicatedStorage")
local Helper = require(replicatedStorage:WaitForChild("Helper"))

local remoteEvent: RemoteEvent = Helper.WaitObjectByPath("ReplicatedStorage/RemoteEvents/RemoteEvent_Hello")

button.MouseButton1Click:Connect(function()
	-- label.Visible = true
	-- label.Text = 'Hello ' .. player.Name

	-- the player is pass with the signal by default
	remoteEvent:FireServer()
end)

remoteEvent.OnClientEvent:Connect(function(message)
	if message == "HideUI" then
		GUI.Enabled = false
	end
end)
