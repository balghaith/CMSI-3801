function first_then_apply(array, predicate, func)
    for _, s in ipairs(array) do
        if predicate(s) then
            return func(s)
        end
    end
    return nil
end

function powers_generator(base, limit)
    return coroutine.create(function()
        local value = 1
        while value <= limit do
            coroutine.yield(value)
            value = value * base
        end
    end)
end

function meaningful_line_count(filename)
    local file, err = io.open(filename, "r")
    if not file then
        error(err)
    end
    local count = 0
    for line in file:lines() do
        local trimmed = line:gsub("^%s+", "")
        if trimmed ~= "" and not trimmed:match("^%s*$") and not trimmed:match("^#") then
            count = count + 1
        end
    end
    file:close()
    return count
end

function say(word)
    if word == nil then
        return ""
    end
    local words = { word }
    local function inner(next)
        if next == nil then
            return table.concat(words, " ")
        end
        words[#words + 1] = next
        return inner
    end
    return inner
end

local QuaternionMeta = {}
QuaternionMeta.__index = QuaternionMeta

function QuaternionMeta.__add(x, y)
    return Quaternion.new(x.a + y.a, x.b + y.b, x.c + y.c, x.d + y.d)
end

function QuaternionMeta.__mul(x, y)
    local a1, b1, c1, d1 = x.a, x.b, x.c, x.d
    local a2, b2, c2, d2 = y.a, y.b, y.c, y.d
    return Quaternion.new(
        a1 * a2 - b1 * b2 - c1 * c2 - d1 * d2,
        a1 * b2 + b1 * a2 + c1 * d2 - d1 * c2,
        a1 * c2 - b1 * d2 + c1 * a2 + d1 * b2,
        a1 * d2 + b1 * c2 - c1 * b2 + d1 * a2
    )
end

function QuaternionMeta.__eq(x, y)
    return x.a == y.a and x.b == y.b and x.c == y.c and x.d == y.d
end

function QuaternionMeta.__tostring(q)
    local parts = {}
    if q.a ~= 0 then
        parts[#parts + 1] = tostring(q.a)
    end
    local function add_term(coeff, sym)
        if coeff == 0 then
            return
        end
        local sign = coeff > 0 and "+" or "-"
        local mag = math.abs(coeff)
        local body = (mag == 1) and sym or (tostring(mag) .. sym)
        if #parts == 0 then
            parts[#parts + 1] = (coeff > 0) and body or ("-" .. body)
        else
            parts[#parts + 1] = sign .. body
        end
    end
    add_term(q.b, "i")
    add_term(q.c, "j")
    add_term(q.d, "k")
    return (#parts > 0) and table.concat(parts) or "0"
end

function QuaternionMeta:coefficients()
    return { self.a, self.b, self.c, self.d }
end

function QuaternionMeta:conjugate()
    return Quaternion.new(self.a, -self.b, -self.c, -self.d)
end

Quaternion = {}

function Quaternion.new(a, b, c, d)
    local obj = {
        a = tonumber(a) or 0,
        b = tonumber(b) or 0,
        c = tonumber(c) or 0,
        d = tonumber(d) or 0
    }
    return setmetatable(obj, QuaternionMeta)
end


