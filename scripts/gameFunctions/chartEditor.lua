--table to string : require('string.buffer').encode(table_data)
--string to table : require('string.buffer').decode(string_data)

function saveSong(directory, chart, metadata)
    local toWrite = ""

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