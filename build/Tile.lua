--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
____exports.Tile = __TS__Class()
local Tile = ____exports.Tile
Tile.name = "Tile"
function Tile.prototype.____constructor(self, x, y, size)
    self.x = x
    self.y = y
    self.size = size
    self.mode = "line"
end
function Tile.prototype.draw(self)
    love.graphics.rectangle(self.mode, self.x * self.size, self.y * self.size, self.size, self.size)
end
function Tile.prototype.clicked(self)
    if self.mode == "line" then
        self.mode = "fill"
    else
        self.mode = "line"
    end
end
return ____exports
