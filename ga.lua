local mod = {}
mod.__index = mod

function mod.new()
  local self = setmetatable({}, mod)
  self.thing = true
  return self
end

return mod
