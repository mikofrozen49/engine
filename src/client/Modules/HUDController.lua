local HUDController = {}

local modules = script.Parent

local MinerServiceClient = require(modules.MinerServiceClient)

function HUDController:init()
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    self.HUDGui = playerGui:WaitForChild("HUD")
    self.rootFrame = self.HUDGui:WaitForChild("RootFrame")

    self:connectBuildButton()

    warn("HUDController init")
end

function HUDController:toggleHUD()
    self.HUDGui.Enabled = not self.HUDGui.Enabled
end

function HUDController:connectBuildButton()
    local buildFrame = self.rootFrame:WaitForChild("BuildFrame")
    local buildButton = buildFrame:WaitForChild("BuildButton")

    buildButton.MouseButton1Click:Connect(function()
        print("BuildButton pressed")
        self:toggleHUD()
        MinerServiceClient:enterBuildMode()
    end)
end

return HUDController