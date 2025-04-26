Song = {}
Song.playing = false

BPM = nil
SONGLENGTH = nil

RATINGS = {}
RATINGS[1] = 0
RATINGS[2] = 0
RATINGS[3] = 0
RATINGS[4] = 0
RATINGS[5] = 0

require("scripts/metronome")

function Song:Start(song)
    --load
    loadSong("testsong")

    print("name: " .. Song.metadata.name)
    print("artist: " .. Song.metadata.artist)
    print("keys: " .. Song.metadata.keys .. "k")
    print("bpm: " .. Song.metadata.bpm)
    print("scroll speed: " .. Song.metadata.scrollspeed)
    print("description: " .. Song.metadata.description)

    --settings stuffs
    BPM = Song.metadata.bpm
    Song.beat = 0
    Song.step = 0

    --spawn notepads
    Notepads:Init()

    --audio handling
    local source = "songs/" .. song .. "/song.ogg"
    local soundData = love.sound.newSoundData("songs/" .. song .. "/song.ogg")
    local toPlay = love.audio.newSource(source, "stream")

    --duration
    SONGLENGTH = soundData:getDuration()

    --yea
    print("song length: " .. SONGLENGTH)

    --set hit flags to false so none of the notes think theyve already been hit
    for i, v in ipairs(Song.chart) do
        v.hitFlag = false
        v.missFlag = false
    end

    --actually start
    Song.elapsed = 0
    Song.playing = true
    love.audio.play(toPlay)
end

function Song:Update(delta)
    Song.elapsed = Song.elapsed + delta

    if not (math.floor(Song.elapsed/(60/BPM)) == Song.beat) then
        print("beat " .. Song.beat)
        beatMetronome()
    end
    Song.beat = math.floor(Song.elapsed/(60/BPM))

    if not (math.floor(Song.elapsed/(15/BPM)) == Song.step) then
        --print("step " .. Song.step)
    end
    Song.step = math.floor(Song.elapsed/(15/BPM))

    if Song.elapsed >= SONGLENGTH then
        Song:Stop()
    end 
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