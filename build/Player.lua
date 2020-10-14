--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____Move = require("Move")
local Move = ____Move.Move
____exports.Player = __TS__Class()
local Player = ____exports.Player
Player.name = "Player"
function Player.prototype.____constructor(self, name, color, b)
    self.name = name
    self.color = color
    self.b = b
end
function Player.prototype.getColor(self)
    return self.color
end
function Player.prototype.getName(self)
    return self.name
end
____exports.HumanPlayer = __TS__Class()
local HumanPlayer = ____exports.HumanPlayer
HumanPlayer.name = "HumanPlayer"
__TS__ClassExtends(HumanPlayer, ____exports.Player)
function HumanPlayer.prototype.____constructor(self, name, color, b)
    HumanPlayer.____super.prototype.____constructor(self, name, color, b)
end
function HumanPlayer.prototype.play(self)
    if love.mouse.isDown(1) then
        local xCoord = math.floor(
            love.mouse.getX() / self.b.tileSize
        )
        local yCoord = math.floor(
            love.mouse.getY() / self.b.tileSize
        )
        if (((xCoord >= 0) and (xCoord <= 7)) and (yCoord >= 0)) and (yCoord <= 7) then
            return __TS__New(Move, xCoord, yCoord, self.color)
        end
    end
    return __TS__New(Move, -1, -1, self.color)
end
____exports.AIPlayer = __TS__Class()
local AIPlayer = ____exports.AIPlayer
AIPlayer.name = "AIPlayer"
__TS__ClassExtends(AIPlayer, ____exports.Player)
function AIPlayer.prototype.____constructor(self, name, color, b, gl)
    AIPlayer.____super.prototype.____constructor(self, name, color, b)
    self.gl = gl
end
function AIPlayer.prototype.play(self)
    love.timer.sleep(0.25)
    local theMoves = {
        __TS__New(Move, -1, -1, self.color)
    }
    local theScore = -1
    do
        local row = 0
        while row < 8 do
            do
                local col = 0
                while col < 8 do
                    local m = __TS__New(Move, row, col, self.color)
                    local results = self.gl:simulateMove(self.b, m)
                    local l = #results
                    if l == theScore then
                        __TS__ArrayPush(theMoves, m)
                    elseif l > theScore then
                        theMoves = {}
                        __TS__ArrayPush(theMoves, m)
                        theScore = l
                    end
                    col = col + 1
                end
            end
            row = row + 1
        end
    end
    local index = math.floor(
        love.math.random() * #theMoves
    )
    return theMoves[index + 1]
end
return ____exports
