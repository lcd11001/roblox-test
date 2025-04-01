print('LavaPart script running')

-- Using touch event
local lavaPart = script.Parent

local function LavaTouch(otherPart)
    print('Lava touched by', otherPart:GetFullName())
end

lavaPart.Touched:Connect(LavaTouch)
