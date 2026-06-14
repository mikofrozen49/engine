local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players           = game:GetService("Players")
local Workspace         = game:GetService("Workspace")
local RunService        = game:GetService("RunService")

local player = Players.LocalPlayer
local mouse  = player:GetMouse()

local GridMath = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Math"):WaitForChild("GridMath"))

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

function getGridPosition()
    local hitPos = mouse.Hit.Position

    return GridMath.snapToGrid(hitPos.X, hitPos.Z)
end

function getFinalPosition()
    local basePart = models[selectedBuildingType]:WaitForChild("Base")
    local gridPos = getGridPosition()

    return Vector3.new(
        gridPos.X,
        basePart.Size.Y / 2,
        gridPos.Y
    )
end

function showGhostModel()
    ghostModel = models[selectedBuildingType]:Clone()

    for _, part in ipairs(ghostModel:GetChildren()) do
        part.CanCollide = false
        part.Transparency = 0.5
        part.BrickColor = BrickColor.new("White")
    end

    ghostModel.Parent = Workspace

    renderSteppedConnection = RunService.RenderStepped:Connect(function()
        ghostModel:PivotTo(CFrame.new(getFinalPosition()))

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

        buildingRemote:FireServer(getFinalPosition(), selectedBuildingType)
    end)
end

return BuildingServiceClient