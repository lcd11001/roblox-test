local base = script.Parent
local debounce = true

local stoneInPit: Part = base.Parent:FindFirstChild("stoneInPit")
local flintInPit: Part = base.Parent:FindFirstChild("flintInPit")
local allLogs: { Part } = base.Parent:FindFirstChild("logModel"):GetChildren() -- Array of Parts

local fire: Fire = base.Parent:FindFirstChild("firePart"):FindFirstChild("Fire")

local function CheckFire()
	local haveFlint = base:GetAttribute("Flint")
	local haveStone = base:GetAttribute("Stone")
	local logCount = base:GetAttribute("LogCount")

	if haveFlint and haveStone and logCount == 3 then
		fire.Enabled = true
	end
end

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

        CheckFire()

		task.wait(2)
		debounce = true
	end
end)
