timer = {}
timers = {}

function timer.create(timerId, time, timerRepeat, func)
    tempArray = {}
    tempArray.time = time
    tempArray.progress = 0
    tempArray.timerRepeat = timerRepeat
    tempArray.isPlaying = false
    tempArray.func = func
    if func then
        tempArray.func()
    end

    timers[timerId] = tempArray
end

function timer.start(timerId)
    timers[timerId].progress = 0
    timers[timerId].isPlaying = true
end

function timer.pause(timerId, bool)
    timers[timerId].isPlaying = bool or false
end

function timer.stop(timerId)
    timers[timerId].isPlaying = false
end

function timer.setProgress(timerId, progressTarget)
    timers[timerId].progress = progressTarget
end

function timer.getProgress(timerId)
    return timers[timerId].progress
end

function timer.remove(timerId)
    timers[timerId] = nil
end

function updateTimers()
    for i, v in pairs(timers) do
        if v.isPlaying then
            v.progress = v.progress + (love.timer.getDelta())

            if v.progress > v.time then
                if v.timerRepeat then
                    v.progress = 0
                else
                    timer.stop(i)
                end

                timer.completed(i)
                v.func()
            end
        end
    end
end
