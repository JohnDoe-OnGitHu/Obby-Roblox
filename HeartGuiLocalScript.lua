local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local screenGui = script.Parent

local loseLifeEvent = ReplicatedStorage:WaitForChild("LoseLifeEvent")

local hearts = {
	screenGui:WaitForChild("Heart1"),
	screenGui:WaitForChild("Heart2"),
	screenGui:WaitForChild("Heart3")
}

local lives = 3

local function updateHearts()
	for i = 1, 3 do
		if i <= lives then
			hearts[i].Visible = true
		else
			hearts[i].Visible = false
		end
	end
end

local function loseLife()
	if lives <= 0 then return end
	
	lives -= 1
	updateHearts()
	
	if lives <= 0 then
		lives = 3
		updateHearts()
		
		local character = player.Character or player.CharacterAdded:Wait()
		local spawnPart  = workspace:WaitForChild("SpawnPart")
		if spawnPart then
			character:WaitForChild("HumanoidRootPart").CFrame =
				spawnPart.CFrame + Vector3.new(0, 5, 0)
		end
	end
end

loseLifeEvent.OnClientEvent:Connect(loseLife)

updateHearts()
