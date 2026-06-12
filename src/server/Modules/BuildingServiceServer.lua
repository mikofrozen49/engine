local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SSS               = game:GetService("ServerScriptService")

local classesFolder = ReplicatedStorage.Shared.Classes
local modulesFolder = SSS.Server.Modules
local dataFolder    = ReplicatedStorage.Shared.Data

local classes = {}
for _, module in ipairs(classesFolder:GetChildren()) do
    classes[module.Name] = require(module)
end

local PlayerDataService = require(modulesFolder.PlayerDataService)
local BuildingsData     = require(dataFolder.BuildingsData)

local buildingRemote = ReplicatedStorage.Remotes.BuildingRemote

local BuildingServiceServer = {}

function BuildingServiceServer.init()
    BuildingServiceServer.connectBuildingRemote()

    warn("BuildingServiceServer init")
end

function BuildingServiceServer.connectBuildingRemote()
    buildingRemote.OnServerEvent:Connect(function(player, position, buildingType)
        if PlayerDataService.getCash(player) < BuildingsData.getPrice(buildingType) then return end

        local object = classes[buildingType].new({
            position = position
        })

        PlayerDataService.addBuilding(player, object)
    end)
end

return BuildingServiceServer