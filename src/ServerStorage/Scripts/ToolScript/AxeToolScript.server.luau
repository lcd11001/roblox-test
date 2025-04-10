local tool: Tool = script.Parent

local replicatedStorage = game:GetService("ReplicatedStorage")
local Helper: Script = require(replicatedStorage:WaitForChild("Helper"))
local PickupModule: Script = require(replicatedStorage:WaitForChild("ModuleScripts"):WaitForChild("PickupModule"))

local trunk: Part = Helper.WaitObjectByPath("Workspace/MyModels/campModel/treeModel/trunk")
local numberOfChops = trunk:GetAttribute("NumberOfChops")
local chopCount = 0
local spawnFolder: Folder = trunk.Parent:WaitForChild("SpawnPoint")
local spawnPoints: { Part } = spawnFolder:GetChildren()
local spawnIndexInUsed = {}

local serverStorage = game:GetService("ServerStorage")
local logPartPrefab = serverStorage:WaitForChild("logSpawnPart")

local function GetSpawnIndex(): number
	local index
	repeat
		index = math.random(1, #spawnPoints)
	until not spawnIndexInUsed[index]
	spawnIndexInUsed[index] = true

	return index
end

local function ResetSpawnIndex(index: number)
	if spawnIndexInUsed[index] then
		spawnIndexInUsed[index] = nil
		-- table.remove(spawnIndexInUsed, index)
	end
end

local function GetLength(t)
	local count = 0
	for _, _ in t do
		count += 1
	end
	return count
end

local function EquipTool()
	-- tool is the child of character
	local character = tool.Parent
	local player = game.Players:GetPlayerFromCharacter(character)
	player:SetAttribute("AxeEquipped", true)
end

local function UnequipTool()
	-- tool is the child of Players/player/Backpack
	local backpack = tool.Parent
	local player = backpack.Parent
	player:SetAttribute("AxeEquipped", false)
end

local function ActivateTool()
	-- tool is the child of character
	local character = tool.Parent

	local humanoid: Humanoid = character:FindFirstChild("Humanoid")
	local animator: Animator = humanoid:FindFirstChild("Animator")
	local axeAnimation: AnimationTrack = animator:LoadAnimation(script.Parent.AxeAnimation)

	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	local player = game.Players:GetPlayerFromCharacter(character)
	player:SetAttribute("UsingAxe", true)

	local distance = (humanoidRootPart.Position - trunk.Position).Magnitude
	if distance < 5 then
		axeAnimation:Play()

		if GetLength(spawnIndexInUsed) == #spawnPoints then
			warn("All spawn points are in use")
			return
		end

		chopCount += 1
		if chopCount == numberOfChops then
			chopCount = 0

			local randIndex = GetSpawnIndex()
			local log: Part = logPartPrefab:Clone()
			log.Position = spawnPoints[randIndex].Position
			log.Rotation = spawnPoints[randIndex].Rotation
			log.Parent = workspace
			log:SetAttribute("SpawnIndex", randIndex)
			PickupModule.TagPickup()

			-- listen for destruction
			log.Destroying:Connect(function()
				ResetSpawnIndex(randIndex)
			end)
		end
	end
end

local function DeactivateTool()
	-- tool is the child of character
	local character = tool.Parent
	local player = game.Players:GetPlayerFromCharacter(character)
	player:SetAttribute("UsingAxe", false)
end

tool.Equipped:Connect(EquipTool)
tool.Unequipped:Connect(UnequipTool)
tool.Activated:Connect(ActivateTool)
tool.Deactivated:Connect(DeactivateTool)
