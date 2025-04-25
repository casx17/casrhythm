function number2time(number)
    local minutes = math.floor(number/60)
    local seconds = math.round(number%60)

    if seconds < 10 then
        seconds = 0 .. seconds
    end

    return minutes .. ":" .. seconds
end