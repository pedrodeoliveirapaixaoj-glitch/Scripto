--========================================--
-- SuperHeroesSystem
-- Config.lua
-- Configurações gerais do sistema
--========================================--

local Config = {}

Config.Version = "1.0.0"

Config.Superman = {
	Name = "Superman",
	WalkSpeed = 40,
	JumpPower = 100,
	MaxHealth = 300,
	CanFly = true,
	HeatVisionDamage = 30,
	FreezeBreathTime = 5,
	PunchDamage = 40
}

Config.SpiderMan = {
	Name = "SpiderMan",
	WalkSpeed = 28,
	JumpPower = 70,
	MaxHealth = 200,
	WebRange = 120,
	WebCooldown = 2,
	CanWallClimb = true,
	SpiderSense = true,
	PunchDamage = 25
}

Config.GUI = {
	ThemeColor = Color3.fromRGB(40,40,40),
	ButtonColor = Color3.fromRGB(0,170,255),
	TextColor = Color3.new(1,1,1)
}

return Config
