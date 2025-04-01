local Helper = {}
local replicatedStorage = game:GetService("ReplicatedStorage") -- Define replicatedStorage
local workspace = game:GetService("Workspace") -- Define workspace

function Helper.FindObjectByPath(root, path)
    local current = root
    for name in string.gmatch(path, "[^/]+") do
        -- print('finding in path', name)
        current = current:FindFirstChild(name)
        if not current then
            return nil -- Return nil if any part of the path is not found
        end
    end
    return current -- Return the final object if found
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
    local path = Helper.FindObjectByPath(workspace, partPath)
    if path == nil then
        print(partPath .. " not found")
        return
    end
    
    -- find the script
    local script = Helper.FindObjectByPath(replicatedStorage, scriptPath)
    if script == nil then
        print(scriptPath .. " not found")
        return
    end

    -- attach the script into the part
    Helper.AttachScript(path, script)
end

return Helper