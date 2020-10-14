--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
____exports.Piece = {}
____exports.Piece.Nothing = 0
____exports.Piece[____exports.Piece.Nothing] = "Nothing"
____exports.Piece.Dark = 1
____exports.Piece[____exports.Piece.Dark] = "Dark"
____exports.Piece.Light = 2
____exports.Piece[____exports.Piece.Light] = "Light"
____exports.Board = __TS__Class()
local Board = ____exports.Board
Board.name = "Board"
function Board.prototype.____constructor(self)
    self.tileSize = 50
    self.board = self:createBoard()
end
function Board.prototype.createBoard(self)
    local b = {}
    do
        local row = 0
        while row < 8 do
            local r = {}
            do
                local col = 0
                while col < 8 do
                    __TS__ArrayPush(r, ____exports.Piece.Nothing)
                    col = col + 1
                end
            end
            __TS__ArrayPush(b, r)
            row = row + 1
        end
    end
    return b
end
function Board.prototype.drawBoardAndPieces(self)
    local halfsize = self.tileSize / 2
    local circleradius = 0.4 * self.tileSize
    do
        local row = 0
        while row < 8 do
            do
                local col = 0
                while col < 8 do
                    love.graphics.setColor(1, 1, 1)
                    love.graphics.rectangle("line", row * self.tileSize, col * self.tileSize, self.tileSize, self.tileSize)
                    local cell = self.board[row + 1][col + 1]
                    if cell == ____exports.Piece.Nothing then
                    elseif cell == ____exports.Piece.Dark then
                        love.graphics.setColor(0, 0, 0)
                        love.graphics.circle("fill", (row * self.tileSize) + halfsize, (col * self.tileSize) + halfsize, circleradius)
                        love.graphics.setColor(1, 1, 1)
                    elseif cell == ____exports.Piece.Light then
                        love.graphics.setColor(1, 1, 1)
                        love.graphics.circle("fill", (row * self.tileSize) + halfsize, (col * self.tileSize) + halfsize, circleradius)
                    else
                        error(
                            __TS__New(Error, "Found a piece on the board that I didn't recognize."),
                            0
                        )
                    end
                    col = col + 1
                end
            end
            row = row + 1
        end
    end
end
function Board.prototype.goodCoords(self, x, y)
    if (((x < 0) or (x > 7)) or (y < 0)) or (y > 7) then
        return false
    end
    return true
end
function Board.prototype.acceptMove(self, m)
    local r = m:getRow()
    local c = m:getCol()
    if self:goodCoords(r, c) then
        self.board[r + 1][c + 1] = m:getColor()
    else
        error(
            __TS__New(Error, "acceptMove() is getting bad coords."),
            0
        )
    end
end
function Board.prototype.spaceOccupied(self, x, y)
    if self:goodCoords(x, y) then
        if self.board[x + 1][y + 1] == ____exports.Piece.Nothing then
            return false
        end
        return true
    else
        error(
            __TS__New(Error, "spaceOccupied() is getting bad coords."),
            0
        )
    end
end
function Board.prototype.getPieceAt(self, x, y)
    if self:goodCoords(x, y) then
        return self.board[x + 1][y + 1]
    else
        error(
            __TS__New(Error, "getPieceAt() is getting bad coords."),
            0
        )
    end
end
function Board.prototype.clearBoard(self)
    self.board = self:createBoard()
end
function Board.prototype.draw(self)
    self:drawBoardAndPieces()
end
return ____exports
