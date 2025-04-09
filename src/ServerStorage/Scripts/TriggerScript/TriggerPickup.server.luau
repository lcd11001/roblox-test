local replicatedStorage = game:GetService("ReplicatedStorage")
local msgEvent: RemoteEvent = replicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RemoteEvent_Msg")

local pickkup: Part = script.Parent
local debounce = true

pickkup.Touched:Connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if player and debounce then
		debounce = false

		local canCarry = player:GetAttribute("CanCarry")
		if canCarry then
			local type = pickkup:GetAttribute("Type")

			player:SetAttribute("Has" .. type, true)
			player:SetAttribute("CanCarry", false)
			pickkup.Transparency = 1

			msgEvent:FireClient(player, "You picked up a " .. type)
		else
			debounce = true
			return
		end

		task.wait(2)
		debounce = true
		pickkup.Transparency = 0
	end
end)
