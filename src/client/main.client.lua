local modulesFolder = script.Parent.Modules

local HUDController = require(modulesFolder.HUDController)
local BuildingServiceClient = require(modulesFolder.BuildingServiceClient)

HUDController:init()
BuildingServiceClient:init()