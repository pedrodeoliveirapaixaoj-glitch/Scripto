-- ======================================
-- SpiderMan.lua
-- Controla todos os poderes do SpiderMan
-- Projeto: SuperHeroesSystem
-- ======================================

local SpiderMan = {}

local activeSwing = {} -- [player] = { att0, rope, bv }
local function getCharHumHrp(player)
	local char = player.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hum or not hrp then return end
	return char, hum, hrp
end

function SpiderMan:WebShoot(player, Config)
	local _, hum, hrp = getCharHumHrp(player)
	if not hum then return end
	if hum.Health <= 0 then return end

	-- “Tiro de teia” simples: raycast e um efeito (part) no ponto
	local origin = hrp.Position
	local direction = hrp.CFrame.LookVector * Config.SpiderMan.WebRange

	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.FilterDescendantsInstances = { player.Character }

	local result = workspace:Raycast(origin, direction, rayParams)
	if not result then return end

	local p = Instance.new("Part")
	p.Anchored = true
	p.CanCollide = false
	p.Size = Vector3.new(0.6, 0.6, 0.6)
	p.Shape = Enum.PartType.Ball
	p.Material = Enum.Material.SmoothPlastic
	p.Color = Color3.fromRGB(245, 245, 245)
	p.Position = result.Position
	p.Parent = workspace

	game:GetService("Debris"):AddItem(p, 1.5)
end

-- Swing básico (toggle): cria uma corda até um ponto na frente, e puxa o player
function SpiderMan:WebSwing(player, Config)
	local _, hum, hrp = getCharHumHrp(player)
	if not hum then return end
	if hum.Health <= 0 then return end

	-- Toggle off
	if activeSwing[player] then
		self:StopSwing(player)
		return
	end

	local origin = hrp.Position
	local direction = hrp.CFrame.LookVector * 140

	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.FilterDescendantsInstances = { player.Character }

	local result = workspace:Raycast(origin, direction, rayParams)
	if not result then return end

	-- Attachment no player
	local att0 = Instance.new("Attachment")
	att0.Name = "SwingAtt0"
	att0.Parent = hrp

	-- Attachment “fake” no mundo (part invisível ancorada)
	local anchor = Instance.new("Part")
	anchor.Name = "SwingAnchor"
	anchor.Anchored = true
	anchor.CanCollide = false
	anchor.Transparency = 1
	anchor.Size = Vector3.new(0.5, 0.5, 0.5)
	anchor.Position = result.Position
	anchor.Parent = workspace

	local att1 = Instance.new("Attachment")
	att1.Name = "SwingAtt1"
	att1.Parent = anchor

	local rope = Instance.new("RopeConstraint")
	rope.Attachment0 = att0
	rope.Attachment1 = att1
	rope.Length = math.max(10, (result.Position - hrp.Position).Magnitude)
	rope.Visible = true
	rope.Thickness = 0.08
	rope.Parent = hrp

	-- Forcinha pra “puxar” e dar sensação de balanço
	local bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
	bv.Velocity = (hrp.CFrame.LookVector * 70) + Vector3.new(0, 15, 0)
	bv.Parent = hrp

	activeSwing[player] = { att0 = att0, rope = rope, bv = bv, anchor = anchor }
end

function SpiderMan:StopSwing(player)
	local data = activeSwing[player]
	if not data then return end
	activeSwing[player] = nil

	if data.rope then data.rope:Destroy() end
	if data.bv then data.bv:Destroy() end
	if data.att0 then data.att0:Destroy() end
	if data.anchor then data.anchor:Destroy() end
end

-- Wall climb simples: dá um “impulso pra cima” se tiver parede na frente (bem básico)
function SpiderMan:WallClimb(player, Config)
	if not Config.SpiderMan.CanWallClimb then return end

	local _, hum, hrp = getCharHumHrp(player)
	if not hum then return end
	if hum.Health <= 0 then return end

	local origin = hrp.Position
	local direction = hrp.CFrame.LookVector * 4

	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.FilterDescendantsInstances = { player.Character }

	local result = workspace:Raycast(origin, direction, rayParams)
	if result then
		hrp.Velocity = Vector3.new(hrp.Velocity.X, 70, hrp.Velocity.Z)
	end
end

function SpiderMan:Cleanup(player)
	self:StopSwing(player)
end

return SpiderMan
