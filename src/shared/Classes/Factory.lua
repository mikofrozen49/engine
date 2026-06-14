local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")

local factoryModel = ReplicatedStorage.Models.Factory
local factoriesFolder = Workspace.Factories

local Factory = {}
Factory.__index = Factory

function Factory.new(config)
    local self = setmetatable({}, Factory)

    self.position = config.position

    self:spawn()

    return self
end

function Factory:spawn()
    local clone = factoryModel:Clone()
    
    clone:PivotTo(CFrame.new(self.position))

    clone.Parent = factoriesFolder
end

return Factory