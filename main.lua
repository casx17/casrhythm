MouseX, MouseY = 0, 0

local FPSCAP = 60

for i, v in pairs(love.filesystem.getDirectoryItems("scripts/core")) do
    require("scripts/core/" .. string.sub(v, 1, string.len(v) - 4))
end

function love.load()

end

function love.update(delta)
    --caps fps
    Sleep(delta)
end

function love.draw()

end

function Sleep(delta)
    --cap fps
    local s = 1/FPSCAP - delta
    if s > 0 then love.timer.sleep(s) end
end