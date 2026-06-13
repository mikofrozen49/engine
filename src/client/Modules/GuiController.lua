local Players = game:GetService("Players")

local modulesFolder = script.Parent

local BuildingServiceClient = require(modulesFolder.BuildingServiceClient)

local player    = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local HUDGui      = PlayerGui:WaitForChild("HUD")
local buildingGui = PlayerGui:WaitForChild("Building")

local GuiController = {}

function GuiController.init()
    connectHUDButtons()
    connectBuildingButtons()

    warn("GuiController init")
end

function toggleGui(gui)
    gui.Enabled = not gui.Enabled
end

function connectHUDButtons()
    local buildFrame = HUDGui:WaitForChild("RootFrame"):WaitForChild("BuildFrame")

    for _, button in ipairs(buildFrame:GetChildren()) do
        button.MouseButton1Click:Connect(function()
            local buildingType = button:GetAttribute("BuildingType")

            toggleGui(HUDGui)
            toggleGui(buildingGui)

            BuildingServiceClient.enterBuildMode(buildingType)
        end)
    end
end

function connectBuildingButtons()
    local exitButton = buildingGui:WaitForChild("Exit")

    exitButton.MouseButton1Click:Connect(function() 
        toggleGui(buildingGui)
        toggleGui(HUDGui)

        BuildingServiceClient.exitBuildMode()
    end)
end


return GuiController