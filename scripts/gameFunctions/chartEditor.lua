--table to string : require('string.buffer').encode(table_data)
--string to table : require('string.buffer').decode(string_data)

function saveSong(directory, chart, metadata)
    local toWrite = ""

    --make new folder with name of song
    love.filesystem.createDirectory(directory)

    --encode chart
    toWrite = require('string.buffer').encode(chart)
    love.filesystem.write(directory .. "/chart.txt", toWrite)

    --encode metadata
    toWrite = SaveData(metadata)
    love.filesystem.write(directory .. "/metadata.txt", toWrite)
end

function loadSong(directory)
    local toRead = ""
    
    --get chart and decode
    toRead = love.filesystem.read(directory .. "/chart.txt")
    Song.chart = LoadData(toRead)

    --get metadata and decode
    toRead = love.filesystem.read(directory .. "/metadata.txt")
    Song.metadata = LoadData(toRead)
end