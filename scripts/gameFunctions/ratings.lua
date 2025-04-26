require("scripts/coreFunctions/timer")

local ratingPaths = {}
local ratingImages = {}
local curImage = 1
local alpha = 0
local scale = 0.85
local alphaTimer = 0

ratingPaths[1] = "images/ratings/miss.png"
ratingPaths[2] = "images/ratings/bad.png"
ratingPaths[3] = "images/ratings/good.png"
ratingPaths[4] = "images/ratings/great.png"
ratingPaths[5] = "images/ratings/perfect.png"

function ratingImagesInit()
    for i, v in pairs(ratingPaths) do
        table.insert(ratingImages, love.graphics.newImage(ratingPaths[i]))
    end
end

function setRating(rating)
    curImage = rating
    alpha = 1
    scale = 0.95
    
    alphaTimer = 0.8

end

function updateRating()
    if alphaTimer <= 0 then
        alpha = alpha + ((0 - alpha) / 15)
    end

    scale = scale + ((0.85 - scale) / 15)

    alphaTimer = alphaTimer - (love.timer.getDelta())
    if alphaTimer < 0 then
        alphaTimer = 0
    end
end

function drawRating()
    if alpha > 0 then
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.draw(ratingImages[curImage], WindowSize.x/2, WindowSize.y/2, 0, scale, scale, ratingImages[curImage]:getWidth()/2, ratingImages[curImage]:getHeight()/2)
    end
end