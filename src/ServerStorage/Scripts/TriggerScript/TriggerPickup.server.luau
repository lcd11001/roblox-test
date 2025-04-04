local replicatedStorage = game:GetService("ReplicatedStorage")
local msgEvent: RemoteEvent = replicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RemoteEvent_Msg")

local pickkup: Part = script.Parent
local debounce = true

pickkup.Touched:Connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if player and debounce then
		-- print('pickup touched', pickkup.Name, 'by', hit.Parent.Name)
		debounce = false

		local canCarry = player:GetAttribute("CanCarry")
		if canCarry then
			local type = pickkup:GetAttribute("Type")
			print("player", player.Name, "picked up", type)
			player:SetAttribute("Has" .. type, true)
			player:SetAttribute("CanCarry", false)
			pickkup.Transparency = 1

			msgEvent:FireClient(player, "You picked up a " .. type)
		else
			print("player", player.Name, "cannot carry more items")
			debounce = true
			return
		end

		task.wait(2)
		debounce = true
		pickkup.Transparency = 0
	end
end)
