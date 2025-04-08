local tool: Tool = script.Parent

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
	local player = game.Players:GetPlayerFromCharacter(character)
	player:SetAttribute("UsingPick", true)
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
