local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local minerModel = ReplicatedStorage.Models.Miner

local Miner = {}
Miner.__index = Miner

function Miner.new(config)
    local self = setmetatable({}, Miner)

    self.position = config.position
    self.id = config.id

    self:spawnMiner()

    return self
end

function Miner:spawnMiner()
    local clone = minerModel:Clone()
    clone.Position = self.position
    clone:SetAttribute("Id", self.id)
    clone.Parent = Workspace
end

return Miner