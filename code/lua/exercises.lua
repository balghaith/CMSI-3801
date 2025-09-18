local M = {}

function M.first_then_apply(a, p, f)
    for _, s in ipairs(a) do
        if p(s) then return f(s) end
    end
    return nil
end

function M.powers_generator(base, limit)
    return coroutine.create(function()
      local k, v = 0, 1
      while v <= limit do
        coroutine.yield(v)
        k = k + 1
        v = base ^ k
      end
    end)
end

function M.meaningful_line_count(filename)
    local fh, err = io.open(filename, "r")
    if not fh then error(err) end
    local c = 0
    for line in fh:lines() do
        local s = line:gsub("^%s+", "")
        if s ~= "" and not s:match("^%s*$") and not s:match("^#") then
            c = c + 1
        end
    end
    fh:close()
    return c
end

function M.say(word)
    if word == nil then return "" end
    local words = { word }
    local function inner(next)
        if next == nil then return table.concat(words, " ") end
        words[#words + 1] = next
        return inner
    end
    return inner
end

local Qmt = {}
Qmt.__index = Qmt

function Qmt.__add(x, y)
    return Quaternion.new(x.a + y.a, x.b + y.b, x.c + y.c, x.d + y.d)
end
function Qmt.__mul(x, y)
    local a1,b1,c1,d1 = x.a,x.b,x.c,x.d
    local a2,b2,c2,d2 = y.a,y.b,y.c,y.d
    return Quaternion.new(
      a1*a2 - b1*b2 - c1*c2 - d1*d2,
      a1*b2 + b1*a2 + c1*d2 - d1*c2,
      a1*c2 - b1*d2 + c1*a2 + d1*b2,
      a1*d2 + b1*c2 - c1*b2 + d1*a2
    )
end
function Qmt.__eq(x, y)
    return x.a==y.a and x.b==y.b and x.c==y.c and x.d==y.d
  end
function Qmt.__tostring(q)
  local parts = {}
  if q.a ~= 0 then parts[#parts+1] = tostring(q.a) end
  local function addterm(coeff, sym)
    if coeff == 0 then return end
    local sign = coeff > 0 and "+" or "-"
    local mag = math.abs(coeff)
    local body = (mag == 1) and sym or (tostring(mag) .. sym)
    if #parts == 0 then
      parts[#parts+1] = (coeff > 0) and body or ("-" .. body)
    else
      parts[#parts+1] = sign .. body
    end
  end
  addterm(q.b, "i"); addterm(q.c, "j"); addterm(q.d,"k")
  return (#parts > 0) and table.concat(parts) or "0"
end

function Qmt.coefficients(self) return {self.a, self.b, self.c, self.d} end
function Qmt.conjugate(self) return M.Quaternion.new(self.a, -self.b, -self.c, -self.d) end

M.Quaternion = {}
function M.Quaternion.new(a, b, c, d)
    local obj = setmetatable({
        a = tonumber(a) or 0,
        b = tonumber(b) or 0,
        c = tonumber(c) or 0,
        d = tonumber(d) or 0
    }, Qmt)

    return setmetatable ({}, {
        __newindex = function() error("immutable") end,
        __eq = Qmt.__eq,
        __add = Qmt.__add,
        __mul = Qmt.__mul,
        __tostring = Qmt.__tostring,
        __index = function(_, k) return obj[k] end
    })
end

_G.first_then_apply = M.first_then_apply
_G.powers_generator = M.powers_generator
_G.meaningful_line_count = M.meaningful_line_count
_G.say = M.say
_G.Quaternion = M.Quaternion

