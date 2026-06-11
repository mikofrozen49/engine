local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SSS               = game:GetService("ServerScriptService")

local classesFolder = ReplicatedStorage.Shared.Classes
local modulesFolder = SSS.Server.Modules

local Miner             = require(classesFolder.Miner)
local PlayerDataService = require(modulesFolder.PlayerDataService)

local buildingRemote = ReplicatedStorage.Remotes.BuildingRemote

local BuildingServiceServer = {}

function BuildingServiceServer.init()
    BuildingServiceServer.connectBuildingRemote()

    warn("BuildingServiceServer init")
end

function BuildingServiceServer.connectBuildingRemote()
    buildingRemote.OnServerEvent:Connect(function(player, position)
        print(player.Name .. " wants to place building in position" ..
                                                    " x:" .. position.x ..
                                                    " y:" .. position.y ..
                                                    " z:" .. position.z)

        local data = {
            position = position
        }

        PlayerDataService.addBuldingData(player, data)
        PlayerDataService.addBuildingObject(player, Miner.new(data))
    end)
end

return BuildingServiceServer