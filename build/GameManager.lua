--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____Board = require("Board")
local Board = ____Board.Board
local Piece = ____Board.Piece
local ____GameLogic = require("GameLogic")
local GameLogic = ____GameLogic.GameLogic
local ____Gui = require("Gui")
local Gui = ____Gui.Gui
local ____Move = require("Move")
local Move = ____Move.Move
local ____Player = require("Player")
local HumanPlayer = ____Player.HumanPlayer
local AIPlayer = ____Player.AIPlayer
local ____TurnQueue = require("TurnQueue")
local TurnQueue = ____TurnQueue.TurnQueue
local State = {}
State.STATE_BEFORE_GAME = 0
State[State.STATE_BEFORE_GAME] = "STATE_BEFORE_GAME"
State.STATE_DURING_GAME = 1
State[State.STATE_DURING_GAME] = "STATE_DURING_GAME"
State.STATE_AFTER_GAME = 2
State[State.STATE_AFTER_GAME] = "STATE_AFTER_GAME"
____exports.GameManager = __TS__Class()
local GameManager = ____exports.GameManager
GameManager.name = "GameManager"
function GameManager.prototype.____constructor(self)
    self.b = __TS__New(Board)
    self.gl = __TS__New(GameLogic)
    self.tq = __TS__New(TurnQueue)
    self.gui = __TS__New(Gui)
    self.winner = ""
    self.state = State.STATE_BEFORE_GAME
    self:createMenu()
end
function GameManager.prototype.createMenu(self)
    local startFunc
    startFunc = function()
        self:restartGame()
    end
    self.state = State.STATE_BEFORE_GAME
    self.gui:createStartGameGui(startFunc)
end
function GameManager.prototype.startGame(self)
    if self.state == State.STATE_BEFORE_GAME then
        local params = self.gui:getParams()
        self.p1 = (params[2] and __TS__New(AIPlayer, params[1], Piece.Dark, self.b, self.gl)) or __TS__New(HumanPlayer, params[1], Piece.Dark, self.b)
        self.p2 = (params[4] and __TS__New(AIPlayer, params[3], Piece.Light, self.b, self.gl)) or __TS__New(HumanPlayer, params[3], Piece.Light, self.b)
    elseif self.state == State.STATE_AFTER_GAME then
    end
    self.b:acceptMove(
        __TS__New(Move, 3, 3, Piece.Dark)
    )
    self.b:acceptMove(
        __TS__New(Move, 4, 4, Piece.Dark)
    )
    self.b:acceptMove(
        __TS__New(Move, 3, 4, Piece.Light)
    )
    self.b:acceptMove(
        __TS__New(Move, 4, 3, Piece.Light)
    )
    self.tq:push(self.p1)
    self.tq:push(self.p2)
    self.state = State.STATE_DURING_GAME
end
function GameManager.prototype.endGame(self)
    local p = self.gl:calculateWinner(self.b)
    if p == Piece.Nothing then
        self.winner = "Nobody"
    else
        self.winner = ((p == Piece.Dark) and "Dark") or "Light"
    end
    self.state = State.STATE_AFTER_GAME
    local restartFunc
    restartFunc = function()
        self:restartGame()
    end
    local mainMenuFunc
    mainMenuFunc = function()
        self.gui:resetGui()
        self:createMenu()
    end
    self.gui:resetGui()
    self.gui:createEndGameGui(restartFunc, mainMenuFunc)
end
function GameManager.prototype.restartGame(self)
    self.b:clearBoard()
    self.tq:clear()
    self:startGame()
end
function GameManager.prototype.update(self, dt)
    local ____switch15 = self.state
    if ____switch15 == State.STATE_BEFORE_GAME then
        goto ____switch15_case_0
    elseif ____switch15 == State.STATE_DURING_GAME then
        goto ____switch15_case_1
    elseif ____switch15 == State.STATE_AFTER_GAME then
        goto ____switch15_case_2
    end
    goto ____switch15_end
    ::____switch15_case_0::
    do
        do
            goto ____switch15_end
        end
    end
    ::____switch15_case_1::
    do
        do
            local player = self.tq:top()
            if not self.gl:canPlayerGo(
                self.b,
                player:getColor()
            ) then
                self.tq:push(
                    self.tq:pop()
                )
                if self.gl:isGameOver(self.b) then
                    self:endGame()
                end
                goto ____switch15_end
            end
            local m = player:play()
            local results = self.gl:simulateMove(self.b, m)
            if #results == 0 then
                goto ____switch15_end
            end
            __TS__ArrayForEach(
                results,
                function(____, move)
                    self.b:acceptMove(move)
                end
            )
            self.tq:push(
                self.tq:pop()
            )
            if self.gl:isGameOver(self.b) then
                self:endGame()
            end
        end
    end
    ::____switch15_case_2::
    do
        do
            goto ____switch15_end
        end
    end
    ::____switch15_end::
end
function GameManager.prototype.drawGameState(self)
    local x = 0
    local y = 8 * self.b.tileSize
    local ____switch25 = self.state
    if ____switch25 == State.STATE_BEFORE_GAME then
        goto ____switch25_case_0
    elseif ____switch25 == State.STATE_AFTER_GAME then
        goto ____switch25_case_1
    elseif ____switch25 == State.STATE_DURING_GAME then
        goto ____switch25_case_2
    end
    goto ____switch25_end
    ::____switch25_case_0::
    do
        do
            love.graphics.print("Game not started yet.", x, y)
            goto ____switch25_end
        end
    end
    ::____switch25_case_1::
    do
        do
            love.graphics.print(
                ("Game Over! " .. tostring(self.winner)) .. " is the winner.",
                x,
                y
            )
            goto ____switch25_end
        end
    end
    ::____switch25_case_2::
    do
        do
            love.graphics.print(
                ("Player " .. tostring(
                    self.tq:top():getName()
                )) .. "'s turn.",
                x,
                y
            )
            local scores = self.gl:calculateScore(self.b)
            love.graphics.print(
                {
                    {1, 1, 1, 1},
                    "Score: ",
                    {0, 0, 0, 1},
                    tostring(scores[1]) .. " ",
                    {1, 1, 1, 1},
                    tostring(scores[2])
                },
                x,
                y + 30
            )
            goto ____switch25_end
        end
    end
    ::____switch25_end::
end
function GameManager.prototype.draw(self)
    local ____switch30 = self.state
    if ____switch30 == State.STATE_BEFORE_GAME then
        goto ____switch30_case_0
    elseif ____switch30 == State.STATE_DURING_GAME then
        goto ____switch30_case_1
    elseif ____switch30 == State.STATE_AFTER_GAME then
        goto ____switch30_case_2
    end
    goto ____switch30_end
    ::____switch30_case_0::
    do
        do
            self.gui:draw()
            goto ____switch30_end
        end
    end
    ::____switch30_case_1::
    do
        do
            self:drawGameState()
            self.b:draw()
            goto ____switch30_end
        end
    end
    ::____switch30_case_2::
    do
        do
            self.gui:draw()
            self.b:draw()
            self:drawGameState()
            goto ____switch30_end
        end
    end
    ::____switch30_end::
end
function GameManager.prototype.mousePressed(self, x, y, button)
    self.gui:mousePressed(x, y, button)
end
return ____exports
