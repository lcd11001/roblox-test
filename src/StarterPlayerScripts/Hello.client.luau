print("Hello world, from client!")


local box = game.Workspace:WaitForChild("MyParts"):WaitForChild("box")

print("before " .. tostring(box.BrickColor))

-- not working, it should be done in the server script
box.BrickColor = BrickColor.new(Color3.fromRGB(255, 0, 0))
print("after " .. tostring(box.BrickColor))
