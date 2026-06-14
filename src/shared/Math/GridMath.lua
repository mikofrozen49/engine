local GRID_SIZE = 2

local GridMath = {}

function GridMath.snapToGrid(x, y)
    return Vector2.new(
        math.floor(x / GRID_SIZE + 0.5) * GRID_SIZE,
        math.floor(y / GRID_SIZE + 0.5) * GRID_SIZE
    )
end

return GridMath