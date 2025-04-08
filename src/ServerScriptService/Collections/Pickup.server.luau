local replicatedStorage = game:GetService("ReplicatedStorage")
local msgEvent: RemoteEvent = replicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RemoteEvent_Msg")
local Helper = require(replicatedStorage:WaitForChild("Helper"))
-- local pitBase = workspace.MyModels.campModel.firePitModel.pitBase
local pitBase = Helper.WaitObjectByPath("Workspace/MyModels/campModel/firePitModel/pitBase")

--[[
    When you have multiple parts that need to run the same code, 
    Lua has a special service called CollectionService 
    that we can use to have just one script 
    and attach it to all the parts using tags.
]]

print("Pickup script started")

local collectionService = game:GetService("CollectionService")
local taggedParts = collectionService:GetTagged("TAG_PICKUP")

for _, part in ipairs(taggedParts) do
	print("Attaching Pickup script to", part.Name)
	local debounce = true
	part.Touched:Connect(function(hit)
		-- local pitBase = workspace.MyModels.campModel.firePitModel.pitBase
		-- local pitBase = workspace:WaitForChild("MyModels"):WaitForChild("campModel"):WaitForChild("firePitModel"):WaitForChild("pitBase")
		-- local pitBase = Helper.WaitObjectByPath("Workspace/MyModels/campModel/firePitModel/pitBase")
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if player and debounce then
			debounce = false

			local canCarry = player:GetAttribute("CanCarry")
			if canCarry then
				local type = part:GetAttribute("Type")
				print("player", player.Name, "picked up", type)

				-- If we have all needed logs, show message immediately
				if type == "Log" and pitBase:GetAttribute("LogCount") >= 3 then
					msgEvent:FireClient(player, "We have enough logs!", true)
					task.wait(2)
					debounce = true
					return
				end

				-- If we have all needed flint, show message immediately
				if type == "Flint" and pitBase:GetAttribute("Flint") == true then
					msgEvent:FireClient(player, "We already have flint!", true)
					task.wait(2)
					debounce = true
					return
				end

				-- If we have all needed stone, show message immediately
				if type == "Stone" and pitBase:GetAttribute("Stone") == true then
					msgEvent:FireClient(player, "We already have stone!", true)
					task.wait(2)
					debounce = true
					return
				end

				player:SetAttribute("Has" .. type, true)
				player:SetAttribute("CanCarry", false)
				part.Transparency = 1

				msgEvent:FireClient(player, "You picked up a " .. type, false)
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
