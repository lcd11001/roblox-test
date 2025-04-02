print ('click me script running')

local player = game.Players.LocalPlayer
local button = script.Parent
local label = button.Parent:WaitForChild('TextLabel')

local replicatedStorage = game:GetService("ReplicatedStorage")
local Helper = require(replicatedStorage:WaitForChild("Helper"))

local remoteEvent = Helper.WaitObjectByPath("ReplicatedStorage/RemoteEvents/RemoteEvent_Hello")

button.MouseButton1Click:Connect(function()
    -- print(button.Name .. ' clicked')
    -- label.Visible = true
    -- label.Text = 'Hello ' .. player.Name

    -- the player is pass with the signal by default
    remoteEvent:FireServer()
end)