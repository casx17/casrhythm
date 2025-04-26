--table to string : require('string.buffer').encode(table_data)
--string to table : require('string.buffer').decode(string_data)

local keys
local color = {r, g, b, a}

local measure
local scroll = 0
local scrollTarget = 0
local rows = 47
local tileSize = WindowSize.y/16

local gridWidth = WindowSize.x / 3

function drawChartEditor()
    keys = Song.metadata.keys 

    for j = 1, rows do
        for i = 1, keys do
            --get measure
            measure = math.ceil(j/4)

            --set colors for tile
            color = 
            {
                r = math.min((i + j%2)%2 + 0.9, 1) - (measure+1)%2/3, 
                g = math.min((i + j%2)%2 + 0.9, 1) - (measure+1)%2/3,
                b = math.min((i + j%2)%2 + 0.9, 1) - (measure+1)%2/3,
                a = 1
            }      

            --pos
            local tileX = (tileSize * (i - 1) + WindowSize.x/2 - gridWidth/2) - WindowSize.x/5
            local tileY = (j - 1) * tileSize - scroll

            --check for mouse collision to brighten tiles
            if tileMouseColliding(tileX, tileY, tileSize, tileSize) then
                love.graphics.setColor(color.r*1.1, color.g*1.1, color.b*1.1, color.a)
            else
                love.graphics.setColor(color.r, color.g, color.b, color.a)
            end

            --draw tiles
            love.graphics.rectangle("fill", tileX, tileY, tileSize, tileSize)

            --outline stuff
            color = 
            {
                r = 0.8 - (measure+1)%2/3, 
                g = 0.8 - (measure+1)%2/3,
                b = 0.8 - (measure+1)%2/3,
                a = 1
            }      

            --check for mouse collision same thing yea
            if tileMouseColliding(tileX, tileY, tileSize, tileSize) then
                love.graphics.setColor(color.r*1.1, color.g*1.1, color.b*1.1, color.a)
            else
                love.graphics.setColor(color.r, color.g, color.b, color.a)
            end

            --actually draw outline
            love.graphics.setLineWidth(5)
            love.graphics.rectangle("line", tileX, tileY, tileSize, tileSize)
            
        end
    end
end

function updateChartEditor()
    if scrollTarget < 0 then
        scrollTarget = 0
    end

    scroll = scroll + (scrollTarget - scroll) / 5
end

function chartEditorWheelmoved(x, y)
    scrollTarget = scrollTarget + y * -20
end

function tileMouseColliding(x, y, width, height)
    if MouseX >= x and MouseX <= x + width - 0.1 and MouseY >= y and MouseY <= y + height - 0.1 then
        return true
    else
        return false
    end
end

function saveSong(directory, chart, metadata)
    local toWrite = ""

    --sort chart
    chart = sortChartByStep(chart)

    --make new folder with name of song
    love.filesystem.createDirectory("songs/" .. directory)

    --encode chart
    SaveEncodedFile("songs/" .. directory .. "/chart.txt", chart)

    --encode metadata
    SaveEncodedFile("songs/" .. directory .. "/metadata.txt", metadata)
end

function loadSong(directory)
    local toRead = ""
    
    --get chart and decode
    Song.chart = LoadDecodedFile("songs/" .. directory .. "/chart.txt")

    --get metadata and decode
    Song.metadata = LoadDecodedFile("songs/" .. directory .. "/metadata.txt")
end