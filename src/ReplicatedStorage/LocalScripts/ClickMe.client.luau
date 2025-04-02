print ('click me script running')

local player = game.Players.LocalPlayer
local button = script.Parent
local label = button.Parent:WaitForChild('TextLabel')

button.MouseButton1Click:Connect(function()
    print(button.Name .. ' clicked')
    label.Visible = true
    label.Text = 'Hello ' .. player.Name
end)