local playersData = {}

local PlayerDataService = {}

function PlayerDataService.init(player)
    playersData[player.UserId] = {
        cash = 1000,
        nextId = 0,
        buildings = {}
    }

    warn("PlayerDataService init")
end

function PlayerDataService.getCash(player)
    return playersData[player.UserId].cash
end

function PlayerDataService.spendCash(player, amount)
    playersData[player.UserId].cash -= amount
end

function PlayerDataService.addBuilding(player, object)
    local data = playersData[player.UserId]

    data.nextId += 1
    local id = data.nextId

    data.buildings[id] = object

    print(data)
end

return PlayerDataService