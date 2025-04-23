WindowSize = {}
WindowSize.x = 900
WindowSize.y = 600

local scale
local realWidth, realHeight

function WindowUpdate()
    realWidth, realHeight = love.window.getMode()
    scale = math.min(realWidth / WindowSize.x, realHeight / WindowSize.y)

    WindowDraw()
end

function WindowDraw()
    love.graphics.scale(scale)
    love.graphics.translate((realWidth - WindowSize.x * scale) / scale / 2, (realHeight - WindowSize.y * scale) / scale / 2)

end

function BlackBars()
    love.graphics.setColor(0, 0, 0, 1)

    --left black bar
    love.graphics.rectangle("fill",
    -(realWidth / scale - WindowSize.x) / 2,
    0,
    (realWidth / scale - WindowSize.x) / 2,
    WindowSize.y)

    --right black bar
    love.graphics.rectangle("fill",
    WindowSize.x,
    0,
    (realWidth / scale - WindowSize.x) / 2,
    WindowSize.y)

    --top black bar
    love.graphics.rectangle("fill",
    0,
    -(realHeight / scale - WindowSize.y) / 2,
    WindowSize.x,
    (realHeight / scale - WindowSize.y) / 2)

    --bottom black bar
    love.graphics.rectangle("fill",
    0,
    WindowSize.y,
    WindowSize.x,
    (realHeight / scale - WindowSize.y) / 2)
end