local modulesFolder = script.Parent.Modules

local GuiController         = require(modulesFolder.GuiController)
local BuildingServiceClient = require(modulesFolder.BuildingServiceClient)

GuiController.init()
BuildingServiceClient.init()