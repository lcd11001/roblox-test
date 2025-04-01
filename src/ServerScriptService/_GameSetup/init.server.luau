print("Initializing Game...")

-- Get references
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Require the helper module
local Helper = require(replicatedStorage:WaitForChild("Helper"))

-- Attach the script to the lava
local LavaPartPath = "MyParts/LavaPart"
local LavaPartScriptPath = "Scripts/LavaScript/LavaPartScript"
Helper.AttachScriptFromPath(LavaPartPath, LavaPartScriptPath)