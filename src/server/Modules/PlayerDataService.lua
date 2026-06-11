local Players = game:GetService("Players")

local playersData = {}

local PlayerDataService = {}

function PlayerDataService.init()
    Players.PlayerAdded:Connect(function(player)
        playersData[player.UserId] = {
            cash = 0,
            nextId = 0,
            buildingData = {},
            buildingObjects = {}
        }
    end)
end

function PlayerDataService.addBuldingData(player, data)
    local playerData = playersData[player.UserId]

    playerData.nextId += 1
    local id = playerData.nextId

    playerData.buildingData[id] = data

    print(playerData)
end

function PlayerDataService.addBuildingObject(player, data)
    local playerData = playersData[player.UserId]

    local id = playerData.nextId
    data.id = id

    playerData.buildingObjects[id] = data
end

return PlayerDataService