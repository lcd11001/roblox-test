local treeModel = workspace.MyModels.TreeModel
treeModel:PivotTo(CFrame.new( 0, 0, -10))
task.wait(5)
treeModel:PivotTo(CFrame.new( -10, 0, -20))