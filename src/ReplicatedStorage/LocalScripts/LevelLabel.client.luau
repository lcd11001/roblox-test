local label: TextLabel = script.Parent
local player = script:FindFirstAncestorOfClass("Player")
local playerVariables = player:WaitForChild("PlayerVariables")
local pLevel: IntValue = playerVariables:WaitForChild("Level")

label.Text = "Level: " .. tostring( pLevel.Value)

pLevel.Changed:Connect(function()
    label.Text = "Level: " .. tostring( pLevel.Value)
end)