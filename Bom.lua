--========================================--
-- SuperHeroesSystem
-- HeroServer.lua
-- Script do Servidor (autoridade dos poderes)
--========================================--

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local SelectHeroRE = RemoteEvents:WaitForChild("SelectHero")
local UsePowerRE = RemoteEvents:WaitForChild("UsePower")

local SystemFolder = ReplicatedStorage:WaitForChild("SuperHeroesSystem")
local Config = require(SystemFolder:WaitForChild("Config"))

local HeroesFolder = script.Parent:WaitForChild("Heroes")
local Superman = require(HeroesFolder:WaitForChild("Superman"))
local SpiderMan = require(HeroesFolder:WaitForChild("SpiderMan"))

-- Estado do jogador
local playerHero = {}   -- [player] = "Superman"/"SpiderMan"
local cooldowns = {}    -- [player] = { WebShoot = t, ... }

local function getCharHum(player)
	local char = player.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hum or not hrp then return end
	return char, hum, hrp
end

local function applyStats(player, heroName)
	local char, hum = getCharHum(player)
	if not hum then return end

	if heroName == "Superman" then
		hum.WalkSpeed = Config.Superman.WalkSpeed
		hum.JumpPower = Config.Superman.JumpPower
		hum.MaxHealth = Config.Superman.MaxHealth
		hum.Health = hum.MaxHealth
	elseif heroName == "SpiderMan" then
		hum.WalkSpeed = Config.SpiderMan.WalkSpeed
		hum.JumpPower = Config.SpiderMan.JumpPower
		hum.MaxHealth = Config.SpiderMan.MaxHealth
		hum.Health = hum.MaxHealth
	end
end

local function canUse(player, powerName, cd)
	cooldowns[player] = cooldowns[player] or {}
	local last = cooldowns[player][powerName]
	if last and (os.clock() - last) < cd then
		return false
	end
	cooldowns[player][powerName] = os.clock()
	return true
end

-- Seleção de herói
SelectHeroRE.OnServerEvent:Connect(function(player, heroName)
	if heroName ~= "Superman" and heroName ~= "SpiderMan" then
		return
	end

	playerHero[player] = heroName
	applyStats(player, heroName)

	-- opcional: desliga voo ao trocar
	if heroName ~= "Superman" then
		Superman:StopFly(player)
	end
end)

-- Uso de poderes
UsePowerRE.OnServerEvent:Connect(function(player, powerName)
	local heroName = playerHero[player]
	if not heroName then return end

	-- Segurança simples: só deixa usar poder do herói escolhido
	if heroName == "Superman" then
		if powerName == "Fly" then
			Superman:Fly(player, Config)
		elseif powerName == "HeatVision" then
			Superman:HeatVision(player, Config)
		elseif powerName == "FreezeBreath" then
			Superman:FreezeBreath(player, Config)
		end

	elseif heroName == "SpiderMan" then
		if powerName == "WebShoot" then
			if not canUse(player, "WebShoot", Config.SpiderMan.WebCooldown) then return end
			SpiderMan:WebShoot(player, Config)
		elseif powerName == "WebSwing" then
			SpiderMan:WebSwing(player, Config)
		elseif powerName == "WallClimb" then
			SpiderMan:WallClimb(player, Config)
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	playerHero[player] = nil
	cooldowns[player] = nil
	Superman:StopFly(player)
	SpiderMan:Cleanup(player)
end)

print("HeroServer carregado com sucesso!")
