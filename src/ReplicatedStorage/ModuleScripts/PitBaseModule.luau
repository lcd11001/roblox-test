local replicatedStorage = game:GetService("ReplicatedStorage")
local replayEvent: RemoteEvent = replicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RemoteEvent_Replay")

local PitBase = {}

local signTextLabel = workspace
	:WaitForChild("MyModels")
	:WaitForChild("campModel")
	:WaitForChild("signModel")
	:WaitForChild("back")
	:WaitForChild("signGui")
	:WaitForChild("signLabel")

function PitBase.CheckFire(base: Part, fire: Fire, player: Player)
	local haveFlint = base:GetAttribute("Flint")
	local haveStone = base:GetAttribute("Stone")
	local logCount = base:GetAttribute("LogCount")

	if haveFlint and haveStone and logCount == 3 then
		fire.Enabled = true

		local levelVariable = player.PlayerVariables.Level
		levelVariable.Value += 1

		task.wait(3)
		replayEvent:FireAllClients("Show")
	end

	PitBase.ShowMessage(base)
end

function PitBase.ShowMessage(base: Part)
	local haveFlint = base:GetAttribute("Flint")
	local haveStone = base:GetAttribute("Stone")
	local logCount = base:GetAttribute("LogCount")

	local message = ""
	local startMsg = "We need "
	local flintMsg = "Flint"
	local stoneMsg = "Stone"
	local logMsg = " Wood"

	if haveFlint and haveStone and logCount == 3 then
		message = "Well done! You lit the fire!"
	else
		if not haveFlint then
			message = message .. flintMsg
		end
		if not haveStone then
			message = message .. (#message > 0 and ", " or "") .. stoneMsg
		end
		if logCount < 3 then
			message = message .. (#message > 0 and " and " or "") .. (3 - logCount) .. logMsg .. " more"
		end

		message = startMsg .. message
	end

	if signTextLabel then
		signTextLabel.Text = message
	else
		warn("signTextLabel not found")
	end
end

return PitBase
