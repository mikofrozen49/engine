local MinerServiceClient = {}

function MinerServiceClient:init()
    local player = game.Players.LocalPlayer

    self.mouse = player:GetMouse()
    self.isBuildMode = false

    self:connectMouseInput()

    warn("MinerServiceClient init")
end

function MinerServiceClient:connectMouseInput()
    self.mouse.Button1Down:Connect(function()
        if not self.isBuildMode then return end

        local hitPos = self.mouse.Hit.Position

        print(hitPos)
    end)
end

function MinerServiceClient:enterBuildMode()
    self.isBuildMode = true
end

return MinerServiceClient