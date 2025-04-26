function updateMouse()
    local x, y = love.mouse.getPosition()

    MouseX = (x / scale) - offsetX
    MouseY = (y / scale) - offsetY
end