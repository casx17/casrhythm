BPM = 100
Song = {}

function Song:Start(song)
    --load
    loadSong("testsong")

    print("name: " .. Song.metadata.name)
    print("artist: " .. Song.metadata.artist)
    print("keys: " .. Song.metadata.keys .. "k")
    print("bpm: " .. Song.metadata.bpm)
    print("description: " .. Song.metadata.description)

    Notepads:Init()

    --audio handling
    local source = song .. "/song.ogg"
    local soundData = love.sound.newSoundData(song .. "/song.ogg")
    local toPlay = love.audio.newSource(source, "stream")

    print("song length: " .. soundData:getDuration())

    for i, v in ipairs(Song.chart) do
        Notes:Spawn(v.)
    end

    --cool stuff
    Song.playing = true
    love.audio.play(toPlay)
end

function Song:Stop()
    Song.playing = false
end

function Song:Pause(bool)
    Song.playing = bool
end

function Song:SetProgress(toSet)
    Song.progress = toSet
end

function Song:GetProgress()
    return Song.progress
end