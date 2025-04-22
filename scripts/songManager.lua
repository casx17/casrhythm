function Song:Start(song)

end

function Song:Stop()

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