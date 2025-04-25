posbar = {}
posbar.w = WindowSize.x/1.075
posbar.h = 12
posbar.x = WindowSize.x/2 - posbar.w/2
posbar.y = WindowSize.y/2 - posbar.h/2 + 270

function drawPosBar()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", posbar.x, posbar.y, posbar.w, posbar.h)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("line", posbar.x, posbar.y, posbar.w, posbar.h)
    
    love.graphics.rectangle("fill", posbar.x, posbar.y, Song.elapsed/SONGLENGTH * posbar.w, posbar.h)

    love.graphics.print(number2time(Song.elapsed), posbar.x, posbar.y - 30, 0, 1.2, 1.2)
    love.graphics.print(number2time(SONGLENGTH), posbar.w, posbar.y - 30, 0, 1.2, 1.2)

end

function updatePosBar()

end