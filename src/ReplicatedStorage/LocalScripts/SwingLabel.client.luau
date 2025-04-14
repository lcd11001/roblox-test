local label: TextLabel = script.Parent
local player = script:FindFirstAncestorOfClass("Player")
local playerVariables = player:WaitForChild("PlayerVariables")
local pSwings: IntValue = playerVariables:WaitForChild("Swings")

label.Text = "Swings: " .. tostring( pSwings.Value)

pSwings.Changed:Connect(function()
    label.Text = "Swings: " .. tostring( pSwings.Value)
end)