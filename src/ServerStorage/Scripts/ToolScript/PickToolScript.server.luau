local tool: Tool = script.Parent

local replicatedStorage = game:GetService("ReplicatedStorage")
local Helper: Script = require(replicatedStorage:WaitForChild("Helper"))
local PickupModule: Script = require(replicatedStorage:WaitForChild("ModuleScripts"):WaitForChild("PickupModule"))

local rockModel: Model = Helper.WaitObjectByPath("Workspace/MyModels/campModel/rockModel")
local rockPrimaryPart: Part = rockModel.PrimaryPart
local stonePicks = rockPrimaryPart:GetAttribute("Stone")
local flintPicks = rockPrimaryPart:GetAttribute("Flint")
local pickCount = 0

local flintPrefab: Part = Helper.WaitObjectByPath("ServerStorage/flintPart")
local stonePrefab: Part = Helper.WaitObjectByPath("ServerStorage/stonePart")

local function EquipTool()
	-- tool is the child of character
	local character = tool.Parent
	local player = game.Players:GetPlayerFromCharacter(character)
	player:SetAttribute("PickEquipped", true)
end

local function UnequipTool()
	-- tool is the child of Players/player/Backpack
	local backpack = tool.Parent
	local player = backpack.Parent
	player:SetAttribute("PickEquipped", false)
end

local function ActivateTool()
	-- tool is the child of character
	local character = tool.Parent
	
	local humanoid: Humanoid= character:FindFirstChild("Humanoid")
	local animator:Animator = humanoid:FindFirstChild("Animator")
	local pickAnimation: Animation = animator:LoadAnimation(tool.PickAnimation)

	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	local player = game.Players:GetPlayerFromCharacter(character)
	player:SetAttribute("UsingPick", true)

	local distance = (humanoidRootPart.Position - rockPrimaryPart.Position).Magnitude
	if distance < 5 then
		pickAnimation:Play()

		pickCount += 1
		if pickCount == stonePicks then
			local stone: Part = stonePrefab:Clone()
			stone.Parent = workspace
			PickupModule.TagPickup()
		elseif pickCount == flintPicks then
			local flint: Part = flintPrefab:Clone()
			flint.Parent = workspace
			PickupModule.TagPickup()
		elseif pickCount > math.max(stonePicks, flintPicks) then
			pickCount = 0
		end
	end
end

local function DeactivateTool()
	-- tool is the child of character
	local character = tool.Parent
	local player = game.Players:GetPlayerFromCharacter(character)
	player:SetAttribute("UsingPick", false)
end

tool.Equipped:Connect(EquipTool)
tool.Unequipped:Connect(UnequipTool)
tool.Activated:Connect(ActivateTool)
tool.Deactivated:Connect(DeactivateTool)
