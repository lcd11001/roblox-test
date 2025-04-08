local replicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")
local msgEvent: RemoteEvent = replicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RemoteEvent_Msg")

local msgFrame: Frame = script.Parent
local msgLabel: TextLabel = msgFrame:WaitForChild("MsgLabel")

local msgQueue: { string } = {} -- Queue to store messages
local isDisplaying: boolean = false -- Flag to check if a message is currently being displayed

local displayId: number = 0 -- ID for the display message, incremented each time a message is received

local function showMessage(message: string, id: number)
	msgFrame.Visible = true
	msgLabel.Text = message

	task.wait(3) -- Display the message for 3 seconds
	if displayId == id then
		-- only hide the message if the ID matches
		msgFrame.Visible = false
	end
end

local function dequeueMessage()
	if #msgQueue > 0 then
		isDisplaying = true
		local message = table.remove(msgQueue, 1) -- Get the first message from the queue
		displayId += 1 -- Increment the display ID
		local id = displayId
		showMessage(message, id)

		isDisplaying = false
		dequeueMessage() -- Check if there are more messages to display
	end
end

-- Luau doesn't provide built‐in syntax for default parameters
local function enqueueMessage(message: string, isQueued: boolean?)
	isQueued = isQueued or false -- If isQueued is nil, default to false

	print("Enqueue Message from server:", message)
	if isQueued then
		table.insert(msgQueue, message) -- Add the message to the queue
		if not isDisplaying then
			dequeueMessage() -- Start displaying messages if none are currently being displayed
		end
	else
		table.clear(msgQueue) -- Clear the queue if a message is currently being displayed
		isDisplaying = false
		displayId += 1 -- Increment the display ID
		local id = displayId
		showMessage(message, id) -- Show the message immediately if not already displaying one
	end
end

msgEvent.OnClientEvent:Connect(enqueueMessage)
