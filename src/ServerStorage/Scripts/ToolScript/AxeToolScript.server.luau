local tool: Tool = script.Parent

local replicatedStorage = game:GetService("ReplicatedStorage")
local Helper: Script = require(replicatedStorage:WaitForChild("Helper"))

local trunk: Part = Helper.WaitObjectByPath("Workspace/MyModels/campModel/treeModel/trunk")
local numberOfChops = trunk:GetAttribute("NumberOfChops")
local chopCount = 0

local function EquipTool()
	-- print(tool.Name .. " Tool equipped")
	-- tool is the child of character
	local character = tool.Parent
	local player = game.Players:GetPlayerFromCharacter(character)
	player:SetAttribute("AxeEquipped", true)
end

local function UnequipTool()
	-- print(tool.Name .. " Tool unequipped")
	-- tool is the child of Players/player/Backpack
	local backpack = tool.Parent
	local player = backpack.Parent
	player:SetAttribute("AxeEquipped", false)
end

local function ActivateTool()
	-- print(tool.Name .. " Tool activated")
	-- tool is the child of character
	local character = tool.Parent
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	local player = game.Players:GetPlayerFromCharacter(character)
	player:SetAttribute("UsingAxe", true)

	local distance = (humanoidRootPart.Position - trunk.Position).Magnitude
	if distance < 5 then
		chopCount += 1
		if chopCount == numberOfChops then
			chopCount = 0
			print("You get a log")
		end
	end
end

local function DeactivateTool()
	-- print(tool.Name .. " Tool deactivated")
	-- tool is the child of character
	local character = tool.Parent
	local player = game.Players:GetPlayerFromCharacter(character)
	player:SetAttribute("UsingAxe", false)
end

tool.Equipped:Connect(EquipTool)
tool.Unequipped:Connect(UnequipTool)
tool.Activated:Connect(ActivateTool)
tool.Deactivated:Connect(DeactivateTool)
