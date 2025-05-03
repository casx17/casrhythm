local FPSCAP = 60

MouseX = 0
MouseY = 0

for i, v in pairs(love.filesystem.getDirectoryItems("scripts/coreFunctions")) do
    require("scripts/coreFunctions/" .. string.sub(v, 1, string.len(v) - 4))
end

for i, v in pairs(love.filesystem.getDirectoryItems("scripts/gameFunctions")) do
    require("scripts/gameFunctions/" .. string.sub(v, 1, string.len(v) - 4))
end

--require("scripts/metronome")

function love.load()
    love.window.setMode(WindowSize.x, WindowSize.y, {resizable=true})
    
    fileSetup()

    --reset chart to fallback (hardcoded)
    chart = {}
    table.insert(chart, 1, {type = 1, step = 9})
    table.insert(chart, 1, {type = 3, step = 16})
    table.insert(chart, 1, {type = 1, step = 8})
    table.insert(chart, 1, {type = 2, step = 10})

    --reset metadata to fallback (also hardcoded)
    metadata = {}
    metadata.name = "Test Song"
    metadata.artist = "cas"
    metadata.keys = 4
    metadata.bpm = 100
    metadata.scrollspeed = 90
    metadata.description = "cool song!!"
    
    --save and load song (for debugging)
    saveSong("testsong", chart, metadata)
    loadSong("testsong")

    --init rating images
    ratingImagesInit()

    --actually start the song
    Song:Start("testsong")
end

function love.update(delta)
    
    --get window width
    WindowWidth, WindowHeight = love.window.getMode()

    updateMouse()
    updateChartEditor()

    if Song.playing then
        Song:Update(delta)
        updateRating()
    end

    --caps fps
    Sleep(delta)
end

function love.draw()
    WindowUpdate()
    love.graphics.setColor(1, 1, 1, 1)

    --actually draw stuff

    drawChartEditor()

    if Song.playing then
        love.graphics.setLineWidth(1)
        
        Notes:Draw()
        Notepads:Draw()

        love.graphics.print(

            "perfects: " .. RATINGS[5] .. "\n" .. 
            "greats: " .. RATINGS[4] .. "\n" ..
            "goods: " .. RATINGS[3] .. "\n" ..
            "bads: " .. RATINGS[2] .. "\n" ..
            "misses: " .. RATINGS[1] .. "\n"

        , 0, 0, 0, 1.8, 1.8)

        drawRating()

        love.graphics.setLineWidth(1.5)

        drawPosBar()
    end

    --spit bar!
    BlackBars()
end

function Sleep(delta)
    --cap fps
    local s = 1/FPSCAP - delta
    if s > 0 then love.timer.sleep(s) end
end

function love.keypressed(key, scancode, isrepeat)
    if Song.playing then
        Notes:Keypressed(key)
    end
end

function love.keyreleased(key, scancode)
    if Song.playing then
        Notes:Keyreleased(key)
    end
end

function love.wheelmoved(x, y)
    chartEditorWheelmoved(x, y)
end

function isOnScreen(x, y, width, height)
    if ((x - width <= WindowSize.x) and (x + width >= 0)) and ((y - height <= WindowSize.y) and (y + height >= 0)) then
        return true
    else
        return false
    end
end