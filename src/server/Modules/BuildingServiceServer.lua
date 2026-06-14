local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SSS               = game:GetService("ServerScriptService")

local classesFolder = ReplicatedStorage.Shared.Classes
local modulesFolder = SSS.Server.Modules
local dataFolder    = ReplicatedStorage.Shared.Data

local classes = {}
for _, module in ipairs(classesFolder:GetChildren()) do
    classes[module.Name] = require(module)
end

local LeaderstatsService = require(script.Parent.LeaderstatsService)
local PlayerDataService = require(modulesFolder.PlayerDataService)
local BuildingsData     = require(dataFolder.BuildingsData)

local buildingRemote = ReplicatedStorage.Remotes.BuildingRemote

local occupiedGrid = {}

local BuildingServiceServer = {}

function BuildingServiceServer.init()
    connectBuildingRemote()

    warn("BuildingServiceServer init")
end

function connectBuildingRemote()
    buildingRemote.OnServerEvent:Connect(function(player, position, buildingType)
        if occupiedGrid[position.X] and occupiedGrid[position.X][position.Z] then return end

        local cash = PlayerDataService.getCash(player)
        local price = BuildingsData.getPrice(buildingType)

        if cash < price then return end

        local object = classes[buildingType].new({
            position = position
        })
        PlayerDataService.addBuilding(player, object)

        PlayerDataService.spendCash(player, price)

        LeaderstatsService.updateLeaderstats(player)

        occupiedGrid[position.X] = occupiedGrid[position.X] or {}
        occupiedGrid[position.X][position.Z] = true
    end)
end

return BuildingServiceServer