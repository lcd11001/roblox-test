-- Using touch event
local lavaPart = script.Parent
local debounce = true

lavaPart.Touched:Connect(function(otherPart)
	local character = otherPart.Parent
	local humanoid = character:FindFirstChild("Humanoid")

	-- reduce the number of times this function is called
	if humanoid and debounce then
		debounce = false
		task.wait(1)
		debounce = true
	end
end)
