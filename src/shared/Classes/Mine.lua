local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")

local mineModel  = ReplicatedStorage.Models.Mine
local minesFolder = Workspace.Mines

local Mine = {}
Mine.__index = Mine

function Mine.new(config)
    local self = setmetatable({}, Mine)

    self.position = config.position

    self:spawn()

    return self
end

function Mine:spawn()
    local clone = mineModel:Clone()

    clone:PivotTo(CFrame.new(self.position))

    clone.Parent = minesFolder
end

return Mine