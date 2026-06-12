local modulesFolder = script.Parent

local PlayerDataService = require(modulesFolder.PlayerDataService)

local LeaderstatsService = {}

function LeaderstatsService.init(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local cash = Instance.new("IntValue")
    cash.Name = "Cash"
    cash.Value = PlayerDataService.getCash(player)
    cash.Parent = leaderstats

    warn("LeaderstatsService init")
end

return LeaderstatsService