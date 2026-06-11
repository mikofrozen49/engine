local SSS = script.Parent

local modulesFolder = SSS.Modules

local BuildingServiceServer = require(modulesFolder.BuildingServiceServer)
local PlayerDataService = require(modulesFolder.PlayerDataService)

BuildingServiceServer.init()
PlayerDataService.init()