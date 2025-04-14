local replicatedStorage = game:GetService("ReplicatedStorage")
local replayEvent = replicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RemoteEvent_Replay")

local function ResetGame()
	replayEvent:FireAllClients("Hide")
	print("Resetting game...")

	-- clean up pickup item
	local items = workspace.PickupItems:GetChildren()
	for _, item in ipairs(items) do
		item:Destroy()
	end

	-- hide logs
	local logs = workspace.MyModels.campModel.firePitModel.logModel:GetChildren()
	for _, log in ipairs(logs) do
		log.Transparency = 1
	end

	-- hide fire
	local fire = workspace.MyModels.campModel.firePitModel.firePart.Fire
	fire.Enabled = false

	-- hide flint
	local flint = workspace.MyModels.campModel.firePitModel.flintInPit
	flint.Transparency = 1

	-- hide stone
	local stone = workspace.MyModels.campModel.firePitModel.stoneInPit
	stone.Transparency = 1

	-- player attributes
	local players = game.Players:GetPlayers()
	for _, player in pairs(players) do
		local attributes = player:GetAttributes()
		for key, _ in pairs(attributes) do
			if key == "CanCarry" then
				player:SetAttribute(key, true)
			else
				player:SetAttribute(key, false)
			end
		end
	end

    -- base attributes
    local base = workspace.MyModels.campModel.firePitModel.pitBase
    base:SetAttribute("Flint", false)
    base:SetAttribute("Stone", false)
    base:SetAttribute("LogCount", 0)
end

replayEvent.OnServerEvent:Connect(function(player)
	print("Replay event triggered by player: " .. player.Name)
	ResetGame()
end)
