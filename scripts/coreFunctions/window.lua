WindowSize = {}
WindowSize.x = 1920
WindowSize.y = 1080

--[[FOR IT TO WORK:

    UNDER LOVE.LOAD IN MAIN ADD "love.window.setMode(WindowSize.x, WindowSize.y, {resizable=true})""

    UNDER LOVE.UPDATE IN MAIN PUT IN "WindowWidth, WindowHeight = love.window.getMode()"

    AT THE BEGINNING OF THE LOVE.DRAW FUNCTION IN MAIN CALL "WindowUpdate()"

    AFTER EVERYTHING HAS BEEN DRAWN (at the end of the draw function) CALL "BlackBars()"
]]

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
    love.graphics.rectangle("fill", -(realWidth / scale - WindowSize.x) / 2, 0, (realWidth / scale - WindowSize.x) / 2, WindowSize.y)

    --right black bar
    love.graphics.rectangle("fill", WindowSize.x, 0, (realWidth / scale - WindowSize.x) / 2, WindowSize.y)

    --top black bar
    love.graphics.rectangle("fill", 0, -(realHeight / scale - WindowSize.y) / 2, WindowSize.x, (realHeight / scale - WindowSize.y) / 2)

    --bottom black bar
    love.graphics.rectangle("fill", 0, WindowSize.y, WindowSize.x, (realHeight / scale - WindowSize.y) / 2)
end