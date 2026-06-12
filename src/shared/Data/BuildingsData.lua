local BuildingsData = {
    Miner = {
        price = 100
    },
    Factory = {
        price = 200
    }
}

function BuildingsData.getPrice(buildingType)
    return BuildingsData[buildingType].price
end

return BuildingsData