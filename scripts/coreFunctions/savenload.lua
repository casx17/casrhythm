--encode data, assuming you only use this script for saving and loading files you probably wont use this a ton

function EncodeData(data)
    return require('string.buffer').encode(data)
end

--same as before but decoding

function DecodeData(data)
    return require('string.buffer').decode(data)
end

--automatically makes a new file with encoded data based on file path and data put in

function SaveEncodedFile(filePath, data)
    love.filesystem.write(filePath, EncodeData(data))
end

--automatically decodes and loads

function LoadDecodedFile(filePath)
    return DecodeData(love.filesystem.read(filePath))
end