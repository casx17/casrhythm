Notes = {}

--width of screen padding so notes fit into a certain section of the screen properly
local padsWidth = WindowSize.x / 4

--note properties
local notepadY
local noteRadius
local keys
local rawStep
local noteX
local noteY

--set it so every note can be hit (each value is a type of note)
local canHit = {true, true, true, true}

--time you have to hit notes around its goal position / step
local leniency = 0.9

--timing windows for rating / if you want certain ratings to be easier or harder, change these
local ratingWindows = {0.9, 0.65, 0.45, 0.2}

--notesound stuffs
noteSound = love.audio.newSource("notesounds/osu.ogg", "static")

function Notes:Draw()
    for i, v in ipairs(Song.chart) do

        --4 key song, 7 key song, etc
        keys = Song.metadata.keys
        
        --auto resize notes based on # of keys
        noteRadius = padsWidth/keys * 0.5
        if noteRadius > 42 then
            noteRadius = 42
        end

        --set note x
        noteX = ((v.type - 1) * padsWidth/keys + WindowSize.x/2) - (keys - 1) * (padsWidth/keys)/2
        
        --get unfiltered step without rounding
        rawStep = Song.elapsed/(15/BPM)

        --put notepads low if downscroll, else high
        if Settings.downscroll then
            notepadY = WindowSize.y - 100
            noteY = notepadY - (v.step - rawStep) * Song.metadata.scrollspeed
        else
            notepadY = 100
            noteY = notepadY + (v.step - rawStep) * Song.metadata.scrollspeed
        end

        --botplay (auto-hit notes)
        if Settings.botplay then
            if Song.step == v.step and not v.hitFlag then
                v.hitFlag = true
                print("note hit strumline")
            end
        end

        --miss if not hit, not already missed, etc
        if rawStep >= v.step + leniency and not v.missFlag and not v.hitFlag then
            v.missFlag = true
            Notes:Miss()
        end

        --dont draw notes if theyve been hit or missed or are off screen or whatever
        if not v.hitFlag then
            if (noteY <= WindowSize.y) and (noteY >= WindowSize.y * -1) then
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.circle("fill", noteX, noteY, noteRadius)
            end
        end
    end
end

function Notes:Keypressed(key)
    if not Settings.botplay then
        for i, v in ipairs(Song.chart) do
            --if you hit a keybind, the note hasnt already been hit, and youre actually able to hit the note
            if key == Settings.keybinds[v.type] and not v.hitFlag and canHit[v.type] then
                
                --if the distance between the current song time and when the note is supposed to arrive is within a certain window (leniency), hit
                if math.abs(v.step - rawStep) <= leniency then
                    --tell game the note got hit
                    v.hitFlag = true
                    canHit[v.type] = false

                    --distance between current time and note arrival time
                    local distance = math.abs(v.step - rawStep)

                    --iterate through each rating window until the "distance" variable exceeds the window size, then grant rating (to ratingSet var)
                    local ratingSet = 0
                    for i, v in ipairs(ratingWindows) do 
                        if distance <= ratingWindows[i] then
                            ratingSet = i
                        end
                    end
                    
                    --offset value by 1-
                    --ratings have to be offset by 1 because "miss" counts as a rating, taking the 1 spot in the array of possible ratings
                    ratingSet = ratingSet + 1
                    RATINGS[ratingSet] = RATINGS[ratingSet] + 1

                    Notes:Hit(ratingSet)
                end
            end
        end
    end
end

function Notes:Keyreleased(key)
    if not Settings.botplay then
        for i, v in ipairs(Settings.keybinds) do
            if key == Settings.keybinds[i] then
                if canHit[i] == false then
                    canHit[i] = true
                end
            end
        end
    end
end

function Notes:Hit(rating)
    print("note hit - rating: " .. rating)
    setRating(rating)
    love.audio.play(noteSound)
    return
end

function Notes:Miss()
    print("note missed")
    setRating(1)
    RATINGS[1] = RATINGS[1] + 1
    return
end