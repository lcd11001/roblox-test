-- print(game.Workspace.MyParts.box.BrickColor)
-- game.Workspace.MyParts.box.Transparency = 0.5


 local box = game.Workspace:WaitForChild("MyParts"):WaitForChild("box")
 box.Transparency = 0.5
--  print('before ' .. tostring(box.BrickColor))
--  box.BrickColor = BrickColor.new(Color3.fromRGB(255, 0, 0))
--  print('after ' .. tostring(box.BrickColor))