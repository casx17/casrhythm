Notepads = {}

local keys = nil
local padsWidth = WindowSize.x / 4
local alpha = 0

function Notepads:Init()
    keys = Song.metadata.keys
end

function Notepads:Draw()
    for i = 1, keys do

        local notepadRadius = padsWidth/keys * 0.5
        if notepadRadius > 42 then
            notepadRadius = 42
        end

        
        local notepadX = ((i - 1) * padsWidth/keys + WindowSize.x/2) - (keys - 1) * (padsWidth/keys)/2

        local notepadY
        if Settings.downscroll then
            notepadY = WindowSize.y - 100
        else
            notepadY = 100
        end

        if not Settings.botplay then
            if love.keyboard.isDown(Settings.keybinds[i]) then
                notepadRadius = notepadRadius * 0.93
            end
        end

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.circle("line", notepadX, notepadY, notepadRadius)
    end
end