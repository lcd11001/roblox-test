local replicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")
local msgEvent: RemoteEvent = replicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RemoteEvent_Msg")

local msgFrame: Frame = script.Parent
local msgLabel: TextLabel = msgFrame:WaitForChild("MsgLabel")

local function showMessage(message: string)
    print("Message from server:", message)
    msgFrame.Visible = true
    msgLabel.Text = message

    task.wait(3) -- Display the message for 3 seconds
    msgFrame.Visible = false
end

msgEvent.OnClientEvent:Connect(showMessage)
