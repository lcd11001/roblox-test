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