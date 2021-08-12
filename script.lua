local dummy = script.Parent
local dummyRootPart = dummy:WaitForChild("HumanoidRootPart")
local humanoid = dummy:WaitForChild("Humanoid")
local PathFinding = game:GetService("PathfindingService")
local path = PathFinding:CreatePath()
local Origen = dummy.Parent
local SpawnDummy = Origen:WaitForChild("Spawn")

function Objetivo()
	
	local target = nil
	
	for i, v in pairs(game.Workspace:GetChildren()) do
		
		local RootPart = v:FindFirstChild("HumanoidRootPart")
		
		if RootPart and v.Name ~= dummy.Name then
			
			if (dummyRootPart.Position - RootPart.Position).magnitude < 40 then
				
				target = RootPart

			end
			
		end
		
	end
	
	return target
	
end


local lejos = false

while wait() do
	
	local Posision = Objetivo()

	if (dummyRootPart.Position - SpawnDummy.Position).magnitude > 100 then
		
		lejos = true
		humanoid:MoveTo(SpawnDummy.Position)
		wait(3)
		lejos = false
		
	end
	
	if Posision and lejos == false then
		
		path:ComputeAsync(dummyRootPart.Position, Posision.Position)
		local waypoints = path:GetWaypoints()

		for _, waypoint in pairs(waypoints) do

			humanoid:MoveTo(waypoint.Position)

		end
		
	else
		
		humanoid:MoveTo(SpawnDummy.Position)
		
	end

end
