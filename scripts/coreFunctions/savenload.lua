function SaveData(data)
    return require('string.buffer').encode(data)
end

function LoadData(data)
    return require('string.buffer').decode(data)
end