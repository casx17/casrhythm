function sortStep(a, b)
    return a.step < b.step
end

function sortChartByStep(array)
    local tempArray = {}
    tempArray = array
    
    table.sort(tempArray, sortStep)

    return tempArray
end