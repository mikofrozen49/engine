local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local mouse = player:GetMouse()
local isBuildMode = false
local buildingRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("BuildingRemote")

local BuildingServiceClient = {}

function BuildingServiceClient.init()
    BuildingServiceClient.connectMouseInput()

    warn("BuildingServiceClient init")
end

function BuildingServiceClient.connectMouseInput()
    mouse.Button1Down:Connect(function()
        if not isBuildMode then return end

        local hitPosition = mouse.Hit.Position
        local position = Vector3.new(
            math.ceil(hitPosition.x),
            math.ceil(hitPosition.y),
            math.ceil(hitPosition.z)
        )

        buildingRemote:FireServer(position)
    end)
end

function BuildingServiceClient.enterBuildMode()
    isBuildMode = true
end

return BuildingServiceClient