local BuildingsData = {
    Mine = {
        price = 50
    },
    Factory = {
        price = 50
    }
}

function BuildingsData.getPrice(buildingType)
    return BuildingsData[buildingType].price
end

return BuildingsData