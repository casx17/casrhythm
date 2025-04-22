Vector2 = {}

local _mt = {

    __index = function (self, index)
        print(index)
    end,

    __add = function (a, b)
        if type(b) == "table" then
            return
                Vector2(
                    a.x + b.x,
                    a.y + b.y
                )
        elseif type(b) == "number" then
            return
                Vector2(
                    a.x + b,
                    a.y + b
                )
        else
            error("YOU CAN'T ADD A " ..  string.upper(type(b)) .. " TO A VECTOR")
        end
    end,

    __sub = function (a, b)
        if type(b) == "table" then
            return
                Vector2(
                    a.x - b.x,
                    a.y - b.y
                )
        elseif type(b) == "number" then
            return
                Vector2(
                    a.x - b,
                    a.y - b
                )
        else
            error("YOU CAN'T SUBTRACT A VECTOR BY A " ..  string.upper(type(b)))
        end
    end,

    __div = function (a, b)
        if type(b) == "table" then
            return
                Vector2(
                    a.x / b.x,
                    a.y / b.y
                )
        elseif type(b) == "number" then
            return
                Vector2(
                    a.x / b,
                    a.y / b
                )
        else
            error("YOU CAN'T DIVIDE A VECTOR BY A " ..  string.upper(type(b)))
        end
    end,

    __mul = function (a, b)
        if type(b) == "table" then
            return
                Vector2(
                    a.x * b.x,
                    a.y * b.y
                )
        elseif type(b) == "number" then
            return
                Vector2(
                    a.x * b,
                    a.y * b
                )
        else
            error("YOU CAN'T MULTIPLY A VECTOR WITH A " ..  string.upper(type(b)))
        end
    end,

    __tostring = function (self)
        return "(" .. self.x .. ", " .. self.y .. ")"
    end
}


setmetatable(Vector2, _mt)

function _mt.__call(self, x, y)
    local v = {
        x = x or 0,
        y = y or 0
    }
    _mt.__index = self
    setmetatable(v, _mt)
    return v
end

function Vector2:getNormal()
    return Vector2(-self.y, self.x)
end

function Vector2:normalize()
    if self:len() ~= 0 then
        return self / self:len()
    else
        return Vector2.zero
    end
end

function Vector2:len()
    return math.sqrt(self.x^2 + self.y^2)
end

function Vector2:dot(other)
    return self.x * other.x + self.y * other.y
end

Vector2.zero = Vector2(0, 0)