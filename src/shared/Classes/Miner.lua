local Miner = {}
Miner.__index = Miner

function Miner.new()
    local self = setmetatable({}, Miner)

    print("object created")

    return self
end

return Miner