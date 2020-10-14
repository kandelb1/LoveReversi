--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____Board = require("Board")
local Piece = ____Board.Piece
local ____Move = require("Move")
local Move = ____Move.Move
____exports.GameLogic = __TS__Class()
local GameLogic = ____exports.GameLogic
GameLogic.name = "GameLogic"
function GameLogic.prototype.____constructor(self)
end
function GameLogic.prototype.canPlaceHere(self, b, m)
    return not b:spaceOccupied(
        m:getRow(),
        m:getCol()
    )
end
function GameLogic.prototype.moveWithinBounds(self, m)
    local r = m:getRow()
    local c = m:getCol()
    if (((r < 0) or (r > 7)) or (c < 0)) or (c > 7) then
        return false
    end
    return true
end
function GameLogic.prototype.nextPosition(self, direction, m)
    return __TS__New(
        Move,
        m:getRow() + direction[1],
        m:getCol() + direction[2],
        m:getColor()
    )
end
function GameLogic.prototype.simulateAllDirections(self, b, m)
    local directions = {{0, -1}, {0, 1}, {-1, 0}, {1, 0}, {-1, -1}, {1, -1}, {-1, 1}, {1, 1}}
    local answer = {}
    __TS__ArrayForEach(
        directions,
        function(____, dir)
            local nextMove = self:nextPosition(dir, m)
            local line = {}
            local sawEndstone = false
            __TS__ArrayPush(line, m)
            while self:moveWithinBounds(nextMove) do
                local p = b:getPieceAt(
                    nextMove:getRow(),
                    nextMove:getCol()
                )
                if p == Piece.Nothing then
                    break
                end
                if p == m:getColor() then
                    __TS__ArrayPush(line, nextMove)
                    sawEndstone = true
                    break
                end
                if p ~= m:getColor() then
                    __TS__ArrayPush(line, nextMove)
                end
                nextMove = self:nextPosition(dir, nextMove)
            end
            if #line == 1 then
                __TS__ArrayPush(answer, {})
            elseif #line == 2 then
                __TS__ArrayPush(answer, {})
            else
                if sawEndstone then
                    __TS__ArrayPush(answer, line)
                else
                    __TS__ArrayPush(answer, {})
                end
            end
        end
    )
    return answer
end
function GameLogic.prototype.simulateMove(self, b, m)
    if not self:moveWithinBounds(m) then
        return {}
    end
    if not self:canPlaceHere(b, m) then
        return {}
    end
    local results = __TS__ArrayFlat(
        self:simulateAllDirections(b, m)
    )
    return results
end
function GameLogic.prototype.canPlayerGo(self, b, p)
    do
        local row = 0
        while row < 8 do
            do
                local col = 0
                while col < 8 do
                    if not b:spaceOccupied(row, col) then
                        local results = self:simulateMove(
                            b,
                            __TS__New(Move, row, col, p)
                        )
                        if #results ~= 0 then
                            return true
                        end
                    end
                    col = col + 1
                end
            end
            row = row + 1
        end
    end
    return false
end
function GameLogic.prototype.isBoardFull(self, b)
    do
        local row = 0
        while row < 8 do
            do
                local col = 0
                while col < 8 do
                    if not b:spaceOccupied(row, col) then
                        return false
                    end
                    col = col + 1
                end
            end
            row = row + 1
        end
    end
    return true
end
function GameLogic.prototype.calculateScore(self, b)
    local darkCount = 0
    local lightCount = 0
    do
        local row = 0
        while row < 8 do
            do
                local col = 0
                while col < 8 do
                    do
                        local p = b:getPieceAt(row, col)
                        if p == Piece.Nothing then
                            goto __continue32
                        end
                        local ____ = ((p == Piece.Dark) and (function()
                            local ____tmp = darkCount
                            darkCount = ____tmp + 1
                            return ____tmp
                        end)()) or (function()
                            local ____tmp = lightCount
                            lightCount = ____tmp + 1
                            return ____tmp
                        end)()
                    end
                    ::__continue32::
                    col = col + 1
                end
            end
            row = row + 1
        end
    end
    return {darkCount, lightCount}
end
function GameLogic.prototype.isGameOver(self, b)
    return self:isBoardFull(b) or ((not self:canPlayerGo(b, Piece.Dark)) and (not self:canPlayerGo(b, Piece.Light)))
end
function GameLogic.prototype.calculateWinner(self, b)
    local darkCount = 0
    local lightCount = 0
    do
        local row = 0
        while row < 8 do
            do
                local col = 0
                while col < 8 do
                    do
                        local p = b:getPieceAt(row, col)
                        if p == Piece.Nothing then
                            goto __continue37
                        end
                        local ____ = ((p == Piece.Dark) and (function()
                            local ____tmp = darkCount
                            darkCount = ____tmp + 1
                            return ____tmp
                        end)()) or (function()
                            local ____tmp = lightCount
                            lightCount = ____tmp + 1
                            return ____tmp
                        end)()
                    end
                    ::__continue37::
                    col = col + 1
                end
            end
            row = row + 1
        end
    end
    if darkCount == lightCount then
        return Piece.Nothing
    end
    return ((darkCount > lightCount) and Piece.Dark) or Piece.Light
end
return ____exports
