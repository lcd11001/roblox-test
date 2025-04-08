local tool: Tool = script.Parent

local replicatedStorage = game:GetService("ReplicatedStorage")
local Helper: Script = require(replicatedStorage:WaitForChild("Helper"))
local PickupModule: Script = require(replicatedStorage:WaitForChild("ModuleScripts"):WaitForChild("PickupModule"))

local rockModel: Model = Helper.WaitObjectByPath("Workspace/MyModels/campModel/rockModel")
local rockPrimaryPart: Part = rockModel.PrimaryPart
local stonePicks = rockPrimaryPart:GetAttribute("Stone")
local flintPicks = rockPrimaryPart:GetAttribute("Flint")
local pickCount = 0
print("stonePicks", stonePicks)
print("flintPicks", flintPicks)

local flintPrefab: Part = Helper.WaitObjectByPath("ServerStorage/flintPart")
local stonePrefab: Part = Helper.WaitObjectByPath("ServerStorage/stonePart")

local function EquipTool()
	print(tool.Name .. " Tool equipped")
	-- tool is the child of character
	local character = tool.Parent
	local player = game.Players:GetPlayerFromCharacter(character)
	player:SetAttribute("PickEquipped", true)
end

local function UnequipTool()
	print(tool.Name .. " Tool unequipped")
	-- tool is the child of Players/player/Backpack
	local backpack = tool.Parent
	local player = backpack.Parent
	player:SetAttribute("PickEquipped", false)
end

local function ActivateTool()
	print(tool.Name .. " Tool activated")
	-- tool is the child of character
	local character = tool.Parent
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	local player = game.Players:GetPlayerFromCharacter(character)
	player:SetAttribute("UsingPick", true)

	local distance = (humanoidRootPart.Position - rockPrimaryPart.Position).Magnitude
	print("Distance to rock: ", distance)
	if distance < 5 then
		pickCount += 1
		print("pickCount", pickCount)
		if pickCount == stonePicks then
			print("You have picked up all stones")
			local stone: Part = stonePrefab:Clone()
			stone.Parent = workspace
			PickupModule.TagPickup()
		elseif pickCount == flintPicks then
			print("You have picked up all flints")
			local flint: Part = flintPrefab:Clone()
			flint.Parent = workspace
			PickupModule.TagPickup()
		elseif pickCount > math.max(stonePicks, flintPicks) then
			pickCount = 0
		end
	else
		print("Too far from rock")
	end
end

local function DeactivateTool()
	print(tool.Name .. " Tool deactivated")
	-- tool is the child of character
	local character = tool.Parent
	local player = game.Players:GetPlayerFromCharacter(character)
	player:SetAttribute("UsingPick", false)
end

tool.Equipped:Connect(EquipTool)
tool.Unequipped:Connect(UnequipTool)
tool.Activated:Connect(ActivateTool)
tool.Deactivated:Connect(DeactivateTool)
