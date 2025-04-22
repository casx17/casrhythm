function table.find(table, value)
    for i, v in pairs(table) do
        if v == value then
            return i
        end
    end
end

function FlatteniTable(tab)
    t = {}
    for i, v in ipairs(tab) do
        if type(v) == "table" then
            for i, v in ipairs(v) do
                table.insert(t, #t + 1, v)
                print(v)
            end
        end
    end
    return t
end

function FlattenVector2(tab)
    t = {}
    for i, v in ipairs(tab) do
        if type(v) == "table" then
            table.insert(t, #t + 1, v.x)
            table.insert(t, #t + 1, v.y)
        end
    end
    return t
end

