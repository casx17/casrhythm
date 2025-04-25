local bodyImage = love.graphics.newImage("images/fun/metronomeBody.png")
local tickImage = love.graphics.newImage("images/fun/metronomeTick.png")
local posOffset = nil
local yTo = WindowSize.y/2
local y = yTo

function loadMetronome()

end

function drawMetronome()
    y = y + ((yTo - y) / 10)
    
    love.graphics.draw(bodyImage, WindowSize.x/2, y, 0, 1, 1, bodyImage:getWidth()/2, bodyImage:getHeight()/2)

    posOffset = Song.elapsed/(30/BPM)
    love.graphics.draw(tickImage, WindowSize.x/2, y+24, math.cos(posOffset) * 0.5, 1, 1, bodyImage:getWidth()/2, bodyImage:getHeight() - 30)
end

function beatMetronome()
    y = y - 8
end