Notes = {}

local keys = nil
local padsWidth = WindowSize.x / 3

local notepadY

function Notes:Draw(type, step)
    for i, v in pairs(Song.chart) do
        

        local keys = Song.metadata.keys
        
        local noteRadius = padsWidth/keys * 0.4
        if noteRadius > 27 then
            noteRadius = 27
        end

        local noteX = ((v.type - 1) * padsWidth/keys + WindowSize.x/2) - (keys - 1) * (padsWidth/keys)/2
        
        if Settings.downscroll then
            notepadY = WindowSize.y - 100
        else
            notepadY = WindowSize.y - 500
        end
        
        local posOffset = Song.elapsed/(15/BPM)
        local noteY = notepadY - (v.step - posOffset) * Song.metadata.scrollspeed

        love.graphics.circle("fill", noteX, noteY, noteRadius)
    end
end