local toSetup = {"songs", "noteskins", "notesounds"}

function fileSetup()
    for i, v in ipairs(toSetup) do
        if not love.filesystem.getInfo(toSetup[i]) then
            love.filesystem.createDirectory(toSetup[i])
            print("created directory- " .. toSetup[i])
        end
    end
end