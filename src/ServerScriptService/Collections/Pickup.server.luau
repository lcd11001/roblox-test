--[[
    When you have multiple parts that need to run the same code, 
    Lua has a special service called CollectionService 
    that we can use to have just one script 
    and attach it to all the parts using tags.
]]

local collectionService = game:GetService("CollectionService")
local taggedParts = collectionService:GetTagged("PickUp")

for _, part in ipairs(taggedParts) do
	print("Attaching Pickup script to", part.Name)
	local debounce = true
	part.Touched:Connect(function(hit)
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if player and debounce then
			debounce = false

			local canCarry = player:GetAttribute("CanCarry")
			if canCarry then
				local type = part:GetAttribute("Type")
				print("player", player.Name, "picked up", type)
				player:SetAttribute("Has" .. type, true)
				player:SetAttribute("CanCarry", false)
				part.Transparency = 1
			else
				print("player", player.Name, "cannot carry more items")
				debounce = true
				return
			end

			task.wait(2)
			debounce = true
			part.Transparency = 0
		end
	end)
end
