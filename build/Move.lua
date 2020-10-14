--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
____exports.Move = __TS__Class()
local Move = ____exports.Move
Move.name = "Move"
function Move.prototype.____constructor(self, x, y, color)
    self.x = x
    self.y = y
    self.color = color
end
function Move.prototype.getRow(self)
    return self.x
end
function Move.prototype.getCol(self)
    return self.y
end
function Move.prototype.getColor(self)
    return self.color
end
return ____exports
