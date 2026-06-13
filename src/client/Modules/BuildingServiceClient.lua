local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players           = game:GetService("Players")
local Workspace         = game:GetService("Workspace")
local RunService        = game:GetService("RunService")

local player = Players.LocalPlayer
local mouse  = player:GetMouse()

local buildingRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("BuildingRemote")

local modelsFolder = ReplicatedStorage:WaitForChild("Models")
local models = {}
for _, model in ipairs(modelsFolder:GetChildren()) do
    local buildingType = model:GetAttribute("BuildingType")
    models[buildingType] = model
end

local isBuildMode = false
local selectedBuildingType
local ghostModel
local FIXED_Y = 1
local renderSteppedConnection

local BuildingServiceClient = {}

function BuildingServiceClient.init()
    connectMouseInput()

    warn("BuildingServiceClient init")
end

function BuildingServiceClient.enterBuildMode(BuildingType)
    isBuildMode = true
    selectedBuildingType = BuildingType

    showGhostModel()
end

function BuildingServiceClient.exitBuildMode()
    isBuildMode = false

    hideGhostModel()
end

function getGridPosition(position)
    local gridSize = 2

    local gridPosition = Vector3.new(
        math.floor(position.X / gridSize + 0.5) * gridSize,
        FIXED_Y,
        math.floor(position.Z / gridSize + 0.5) * gridSize
    )

    return gridPosition
end

function showGhostModel()
    ghostModel = models[selectedBuildingType]:Clone()
    ghostModel.CanCollide = false
    ghostModel.Parent = Workspace

    renderSteppedConnection = RunService.RenderStepped:Connect(function()
        local hitPosition = mouse.Hit.Position
        local position = getGridPosition(hitPosition)

        ghostModel.Position = position
        ghostModel.Parent = Workspace
    end)
end

function hideGhostModel()
    if renderSteppedConnection then
        renderSteppedConnection:Disconnect()
        ghostModel:Destroy()
    end
end

function connectMouseInput()
    mouse.Button1Down:Connect(function()
        if not isBuildMode then return end

        local hitPosition = mouse.Hit.Position
        local position = getGridPosition(hitPosition)

        buildingRemote:FireServer(position, selectedBuildingType)
    end)
end

return BuildingServiceClient