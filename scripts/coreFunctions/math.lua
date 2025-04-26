function math.lerp(a, b, dt)
    return a + (b - a) * dt
end

function math.hypotenuse(a, b)
    return math.sqrt(a^2 + b^2)
end

function math.round(x)
    return math.floor(x + 0.5)
end