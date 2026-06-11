local Players = game:GetService("Players")

local modules = script.Parent
local BuildingServiceClient = require(modules.BuildingServiceClient)

local player = Players.LocalPlayer
local HUDGui = player:WaitForChild("PlayerGui"):WaitForChild("HUD")
local rootFrame = HUDGui:WaitForChild("RootFrame")

local HUDController = {}

function HUDController.init()
    HUDController.connectBuildButton()

    warn("HUDController init")
end

function HUDController.toggleHUD()
    HUDGui.Enabled = not HUDGui.Enabled
end

function HUDController.connectBuildButton()
    local buildFrame = rootFrame:WaitForChild("BuildFrame")
    local buildButton = buildFrame:WaitForChild("BuildButton")

    buildButton.MouseButton1Click:Connect(function()
        HUDController.toggleHUD()
        BuildingServiceClient.enterBuildMode()
    end)
end

return HUDController