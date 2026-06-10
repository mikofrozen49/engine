local modulesFolder = script.Parent.Modules

local HUDController = require(modulesFolder.HUDController)
local MinerServiceClient = require(modulesFolder.MinerServiceClient)

HUDController:init()
MinerServiceClient:init()