local part = script.Parent
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local loseLifeEvent = ReplicatedStorage:WaitForChild("LoseLifeEvent")

local debounce = false

part.Touched:Connect(function(hit)
	if debounce then return end

	local character = hit.Parent
	local humanoid = character and character:FindFirstChild("Humanoid")

	if humanoid then
		local player = Players:GetPlayerFromCharacter(character)
		if player then
			debounce = true

			print("loseLifeEvent atirado para ", player.Name)

			loseLifeEvent:FireClient(player)

			local respawnPart =
				workspace:FindFirstChild("SpawnPart")
				if respawnPart then
					character:WaitForChild("HumanoidRootPart").CFrame =
						respawnPart.CFrame + Vector3.new(0, 5, 0)
				end
				
				task.wait(1)
				debounce = false
		end
	end
end)
