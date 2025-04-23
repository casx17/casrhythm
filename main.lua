local FPSCAP = 60

for i, v in pairs(love.filesystem.getDirectoryItems("scripts/coreFunctions")) do
    require("scripts/coreFunctions/" .. string.sub(v, 1, string.len(v) - 4))
end

for i, v in pairs(love.filesystem.getDirectoryItems("scripts/gameFunctions")) do
    require("scripts/gameFunctions/" .. string.sub(v, 1, string.len(v) - 4))
end

function love.load()
    love.window.setMode(WindowSize.x, WindowSize.y, {resizable=true})
    
    chart = {}

    chart.note1 = {}
    chart.note1.type = 1
    chart.note1.step = 10

    chart.note2 = {}
    chart.note2.type = 2
    chart.note2.step = 15

    metadata = {}
    metadata.name = "Test Song"
    metadata.artist = "cas"
    metadata.keys = 4
    metadata.bpm = 100
    metadata.description = "cool song!!"
    
    saveSong("testsong", chart, metadata)
    loadSong("testsong")

    Song:Start("testsong")
end

function love.update(delta)
    
    --get window width
    WindowWidth, WindowHeight = love.window.getMode()

    --caps fps
    Sleep(delta)
end

function love.draw()
    WindowUpdate()
    love.graphics.setColor(1, 1, 1, 1)

    --actually draw stuff
    Notepads:Draw()

    --spit bar!
    BlackBars()
end

function Sleep(delta)
    --cap fps
    local s = 1/FPSCAP - delta
    if s > 0 then love.timer.sleep(s) end
end