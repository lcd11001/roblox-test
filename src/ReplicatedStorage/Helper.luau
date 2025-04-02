local Helper = {}

-- Roblox doesn't have a built-in global variable like 'workspace', so we need to define it
local replicatedStorage = game:GetService("ReplicatedStorage") -- Define replicatedStorage
local serverStorage = game:GetService("ServerStorage") -- Define serverStorage
local starterGui = game:GetService("StarterGui") -- Define starterGui

function Helper.DetectRoot(path)
	-- get the first part of the path
	local root = string.match(path, "([^/]+)")
	if root == "Workspace" then
		return workspace -- built-in Roblox global variable
	elseif root == "ReplicatedStorage" then
		return replicatedStorage
	elseif root == "ServerStorage" then
		return serverStorage
	elseif root == "StarterGui" then
		return starterGui
	end

    return nil
end

function Helper.FindObjectByPath(path)
	local rootPath = string.match(path, "([^/]+)")
    local current = Helper.DetectRoot(rootPath)
    if current == nil then
        return nil
    end

	local objectPath = string.match(path, "/(.*)")
	for name in string.gmatch(objectPath, "[^/]+") do
		-- print('finding in path', name)
        
		current = current:FindFirstChild(name)
		if not current then
			return nil -- Return nil if any part of the path is not found
		end
	end
	return current -- Return the final object if found
end

function Helper.WaitObjectByPath(path)
	local rootPath = string.match(path, "([^/]+)")
    local current = Helper.DetectRoot(rootPath)
    if current == nil then
        return nil
    end

	local objectPath = string.match(path, "/(.*)")
	for name in string.gmatch(objectPath, "[^/]+") do
		current = current:WaitForChild(name)
	end
	return current
end

function Helper.AttachScript(part, script)
	if part and script then
		local newScript = script:Clone()
		newScript.Parent = part
		print(script.Name .. " attached to " .. part.Name .. "!")
	elseif not part then
		warn("invalid part!")
	elseif not script then
		warn("invalid script!")
	else
		warn(part.Name .. " or " .. script.Name .. " not found!")
	end
end

function Helper.AttachScriptFromPath(partPath, scriptPath)
	-- find the part
	local part = Helper.FindObjectByPath(partPath)
	if part == nil then
		print(partPath .. " not found")
		return
	end

	-- find the script
	local script = Helper.FindObjectByPath(scriptPath)
	if script == nil then
		print(scriptPath .. " not found")
		return
	end

	-- attach the script into the part
	Helper.AttachScript(part, script)
end

return Helper
