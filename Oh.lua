--========================================--
-- SuperHeroesSystem
-- HeroClient.lua
-- Script do Cliente
--========================================--

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

-- Pasta de RemoteEvents
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")

local SelectHero = RemoteEvents:WaitForChild("SelectHero")
local UsePower = RemoteEvents:WaitForChild("UsePower")

-- GUI
local PlayerGui = player:WaitForChild("PlayerGui")
local HeroGUI = PlayerGui:WaitForChild("HeroGUI")

local Frame = HeroGUI:WaitForChild("MainFrame")

local SupermanButton = Frame:WaitForChild("SupermanButton")
local SpiderManButton = Frame:WaitForChild("SpiderManButton")

local FlyButton = Frame:WaitForChild("FlyButton")
local HeatVisionButton = Frame:WaitForChild("HeatVisionButton")
local FreezeBreathButton = Frame:WaitForChild("FreezeBreathButton")

local WebButton = Frame:WaitForChild("WebButton")
local SwingButton = Frame:WaitForChild("SwingButton")
local WallClimbButton = Frame:WaitForChild("WallClimbButton")

------------------------------------------------
-- Seleção de Herói
------------------------------------------------

SupermanButton.MouseButton1Click:Connect(function()
	SelectHero:FireServer("Superman")
end)

SpiderManButton.MouseButton1Click:Connect(function()
	SelectHero:FireServer("SpiderMan")
end)

------------------------------------------------
-- Superman
------------------------------------------------

FlyButton.MouseButton1Click:Connect(function()
	UsePower:FireServer("Fly")
end)

HeatVisionButton.MouseButton1Click:Connect(function()
	UsePower:FireServer("HeatVision")
end)

FreezeBreathButton.MouseButton1Click:Connect(function()
	UsePower:FireServer("FreezeBreath")
end)

------------------------------------------------
-- Homem-Aranha
------------------------------------------------

WebButton.MouseButton1Click:Connect(function()
	UsePower:FireServer("WebShoot")
end)

SwingButton.MouseButton1Click:Connect(function()
	UsePower:FireServer("WebSwing")
end)

WallClimbButton.MouseButton1Click:Connect(function()
	UsePower:FireServer("WallClimb")
end)

print("HeroClient carregado com sucesso!")
