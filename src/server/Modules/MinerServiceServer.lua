local MinerServiceServer = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Miner = require(ReplicatedStorage.Shared.Classes.Miner)

function MinerServiceServer.init()
    Miner.new()
end

return MinerServiceServer