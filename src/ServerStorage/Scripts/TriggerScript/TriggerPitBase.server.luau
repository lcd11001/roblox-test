local base = script.Parent
local debounce = true

local stoneInPit = base.Parent:FindFirstChild("stoneInPit")
local flintInPit = base.Parent:FindFirstChild("flintInPit")
local allLogs = base.Parent:FindFirstChild("logModel"):GetChildren()

base.Touched:Connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if player and debounce then
		-- print('base touched', pickkup.Name, 'by', hit.Parent.Name)
		debounce = false

		local allAttributes = player:GetAttributes()
		for key, value in pairs(allAttributes) do
			-- print(key, value)
			if key == "HasLog" and value == true then
				player:SetAttribute("HasLog", false)
				player:SetAttribute("CanCarry", true)

				-- print("player", player.Name, "dropped log")
				local logCount = base:GetAttribute("LogCount")
				logCount += 1
				base:SetAttribute("LogCount", logCount)

				for i = 1, math.min(logCount, #allLogs) do
					allLogs[i].Transparency = 0
				end
			elseif key == "HasFlint" and value == true then
				player:SetAttribute("HasFlint", false)
				player:SetAttribute("CanCarry", true)

				-- print("player", player.Name, "dropped flint")
				base:SetAttribute("Flint", true)
				flintInPit.Transparency = 0
			elseif key == "HasStone" and value == true then
				player:SetAttribute("HasStone", false)
				player:SetAttribute("CanCarry", true)

				-- print("player", player.Name, "dropped stone")
				base:SetAttribute("Stone", true)
				stoneInPit.Transparency = 0
			end
		end

		task.wait(2)
		debounce = true
	end
end)
