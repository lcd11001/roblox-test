local PitBase = {}

function PitBase.CheckFire(base: Part, fire: Fire)
	local haveFlint = base:GetAttribute("Flint")
	local haveStone = base:GetAttribute("Stone")
	local logCount = base:GetAttribute("LogCount")

	if haveFlint and haveStone and logCount == 3 then
		fire.Enabled = true
	end
end

return PitBase
