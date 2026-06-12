local SSS = script.Parent
local Players = game:GetService("Players")

local modulesFolder = SSS.Modules

local BuildingServiceServer = require(modulesFolder.BuildingServiceServer)
local PlayerDataService     = require(modulesFolder.PlayerDataService)
local LeaderstatsService    = require(modulesFolder.LeaderstatsService)

Players.PlayerAdded:Connect(function(player)
    PlayerDataService.init(player)
    LeaderstatsService.init(player)
end)

BuildingServiceServer.init()
