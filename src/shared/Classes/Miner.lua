local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")

local minerModel   = ReplicatedStorage.Models.Miner
local minersFolder = Workspace.Miners

local Miner = {}
Miner.__index = Miner

function Miner.new(config)
    local self = setmetatable({}, Miner)

    self.position = config.position

    self:spawn()

    return self
end

function Miner:spawn()
    local clone = minerModel:Clone()
    clone.Position = self.position
    clone.Parent = minersFolder
end

return Miner