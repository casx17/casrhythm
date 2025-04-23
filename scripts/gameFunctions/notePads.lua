Notepads = {}

local keys = nil
local padsWidth = WindowSize.x / 3

function Notepads:Init()
    keys = Song.metadata.keys
end

function Notepads:Draw()
    for i = 1, keys do
        
        local notepadRadius = padsWidth/keys * 0.4
        if notepadRadius > 27 then
            notepadRadius = 27
        end

        local notepadX = ((i - 1) * padsWidth/keys + WindowSize.x/2) - (keys - 1) * (padsWidth/keys)/2

        local notepadY
        if Settings.downscroll then
            notepadY = WindowSize.y - 100
        else
            notepadY = WindowSize.y - 500
        end

        if love.keyboard.isDown(Settings.keybinds[i]) then
            notepadRadius = notepadRadius * 0.93
        end

        love.graphics.circle("line", notepadX, notepadY, notepadRadius)
    end
end