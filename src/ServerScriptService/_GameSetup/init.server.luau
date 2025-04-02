print("Initializing Game...")

-- Get references
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Require the helper module
local Helper = require(replicatedStorage:WaitForChild("Helper"))

-- Attach the script to the lava
local LavaPartPath = "Workspace/MyParts/LavaPart"
-- local LavaPartScriptPath = "ServerStorage/Scripts/LavaScript/LavaPartScript"
local LavaPartScriptPath = "ServerStorage/Scripts/LavaScript/LavaPartScript2"
Helper.AttachScriptFromPath(LavaPartPath, LavaPartScriptPath)


-- Attach the script to the trigger
local TriggerPartPath = "Workspace/MyParts/TriggerPart"
local TriggerPartScriptPath = "ServerStorage/Scripts/TriggerScript/TriggerPartScript"
Helper.AttachScriptFromPath(TriggerPartPath, TriggerPartScriptPath)

-- Attach the script to the TextButton
local TextButtonPath = "StarterGui/ScreenGui/Frame/TextButton"
local TextButtonScriptPath = "ReplicatedStorage/LocalScripts/ClickMe"
Helper.AttachScriptFromPath(TextButtonPath, TextButtonScriptPath)

--[[
-- LCD removed: use collection service instead
]]
local collectionService = game:GetService("CollectionService")

-- Attach the script to the Pickup items
local LogSpawnPath = "Workspace/MyModels/campModel/logSpawnPart"
-- local PickupScriptPath = "ServerStorage/Scripts/TriggerScript/TriggerPickup"
-- Helper.AttachScriptFromPath(LogSpawnPath, PickupScriptPath)
local LogSpawnPart: Part = Helper.WaitObjectByPath(LogSpawnPath)
LogSpawnPart:SetAttribute("Type", "Log")
collectionService:AddTag(LogSpawnPart, "PickUp")

local FlintPath = "Workspace/MyModels/campModel/flintPart"
-- Helper.AttachScriptFromPath(FlintPath, PickupScriptPath)
local FlintPart: Part = Helper.WaitObjectByPath(FlintPath)
FlintPart:SetAttribute("Type", "Flint")
collectionService:AddTag(FlintPart, "PickUp")

local StonePath = "Workspace/MyModels/campModel/stonePart"
-- Helper.AttachScriptFromPath(StonePath, PickupScriptPath)
local StonePart: Part = Helper.WaitObjectByPath(StonePath)
StonePart:SetAttribute("Type", "Stone")
collectionService:AddTag(StonePart, "PickUp")