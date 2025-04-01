print ('click me script running')

local button = script.Parent

button.MouseButton1Click:Connect(function()
    print(button.Name .. ' clicked')
end)