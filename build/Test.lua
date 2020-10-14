--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____Board = require("Board")
local Board = ____Board.Board
local Piece = ____Board.Piece
local ____GameLogic = require("GameLogic")
local GameLogic = ____GameLogic.GameLogic
local ____Move = require("Move")
local Move = ____Move.Move
____exports.Test = __TS__Class()
local Test = ____exports.Test
Test.name = "Test"
function Test.prototype.____constructor(self)
end
function Test.prototype.printMoveList(self, moves)
    print("--")
    do
        local i = 0
        while i < #moves do
            local r = moves[i + 1]:getRow()
            local c = moves[i + 1]:getCol()
            local color
            local p = moves[i + 1]:getColor()
            if p == Piece.Nothing then
                color = "Nothing"
            elseif p == Piece.Dark then
                color = "Dark"
            elseif p == Piece.Light then
                color = "Dark"
            else
                error(
                    __TS__New(Error, "What"),
                    0
                )
            end
            print(
                tostring(
                    string.rep(
                        " ",
                        math.floor(i + 1)
                    )
                ) .. ((((("Row:Col:Color " .. tostring(r)) .. ":") .. tostring(c)) .. ":") .. tostring(color))
            )
            i = i + 1
        end
    end
    print("--")
end
function Test.prototype.testGameLogic(self)
    local gl = __TS__New(GameLogic)
    local function testFlipping(self, pml)
        local b = __TS__New(Board)
        b:acceptMove(
            __TS__New(Move, 0, 0, Piece.Light)
        )
        local result = gl:simulateMove(
            b,
            __TS__New(Move, 0, 1, Piece.Dark)
        )
        assert(#result == 0, "test 1")
        b = __TS__New(Board)
        b:acceptMove(
            __TS__New(Move, 0, 0, Piece.Light)
        )
        b:acceptMove(
            __TS__New(Move, 0, 1, Piece.Light)
        )
        result = gl:simulateMove(
            b,
            __TS__New(Move, 0, 2, Piece.Dark)
        )
        assert(#result == 0, "test holy shit")
        b:acceptMove(
            __TS__New(Move, 0, 0, Piece.Dark)
        )
        b:acceptMove(
            __TS__New(Move, 0, 1, Piece.Light)
        )
        result = gl:simulateMove(
            b,
            __TS__New(Move, 0, 2, Piece.Dark)
        )
        assert(#result == 3, "test 2")
        __TS__ArrayForEach(
            result,
            function(____, move)
                assert(
                    move:getColor() == Piece.Dark
                )
            end
        )
        result = gl:simulateMove(
            b,
            __TS__New(Move, 0, 2, Piece.Light)
        )
        assert(#result == 0, "test 3")
        b:acceptMove(
            __TS__New(Move, 0, 2, Piece.Light)
        )
        result = gl:simulateMove(
            b,
            __TS__New(Move, 0, 3, Piece.Dark)
        )
        assert(#result == 4, "test 4")
        __TS__ArrayForEach(
            result,
            function(____, move)
                assert(
                    move:getColor() == Piece.Dark
                )
            end
        )
    end
    testFlipping(nil, self.printMoveList)
end
function Test.prototype.runTests(self)
    print("Running tests...")
    self:testGameLogic()
    print("All tests good!")
end
function Test.prototype.draw(self)
end
return ____exports
