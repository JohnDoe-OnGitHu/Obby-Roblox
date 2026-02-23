local part = script.Parent
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local snowboardModelName = "Snowboard"

local function onTouched(hit)
	local character = hit.Parent
	if not character then return end
	
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	
	if character:FindFirstChild("Snowboard") then
		return
	end
	
	local snowboardTemplate = ReplicatedStorage:FindFirstChild(snowboardModelName)
	if not snowboardTemplate then
		error("ERRO: Não foi possivel detectar modelo Snowboard")
		return
	end
	
	local snowboard = snowboardTemplate:Clone()
	snowboard.Name = "Snowboard"
	snowboard.Parent = character
	
	local primaryPart = snowboard:FindFirstChild("Handle") or snowboard:FindFirstChildWhichIsA("BasePart")
	if not primaryPart then
		error("ERRO: Não foi possivel detectar PrimaryPart")
		return
	end
	
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	or character:FindFirstChild("LowerTorso")
	or character:FindFirstChild("Torso")
	if not rootPart then
		error("ERRO: Não foi possivel detectar HumanoidRootPart")
		return
	end
	
	primaryPart.CFrame = rootPart.CFrame * CFrame.new(0, -3, 0)
	
	local weld = Instance.new("WeldConstraint")
	weld.Part0 = rootPart
	weld.Part1 = primaryPart
	weld.Parent = primaryPart
	
end

part.Touched:Connect(onTouched)
