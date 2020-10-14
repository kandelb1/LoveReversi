--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local Button = __TS__Class()
Button.name = "Button"
function Button.prototype.____constructor(self, x, y, width, height, callback)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.callback = callback
end
function Button.prototype.draw(self)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
function Button.prototype.mousePressed(self, x, y, button)
    if button == 1 then
        if (((x >= self.x) and (x <= (self.x + self.width))) and (y >= self.y)) and (y <= (self.y + self.height)) then
            if self.callback then
                self:callback()
            end
        end
    end
end
local Label = __TS__Class()
Label.name = "Label"
function Label.prototype.____constructor(self, x, y, t, color)
    self.x = x
    self.y = y
    self.text = t
    self.color = color
end
function Label.prototype.draw(self)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print({self.color, self.text}, self.x, self.y)
end
local Checkbox = __TS__Class()
Checkbox.name = "Checkbox"
function Checkbox.prototype.____constructor(self, x, y, p, checked)
    self.x = x
    self.y = y
    self.p = p
    self.width = 30
    self.height = 30
    self.checked = checked
    self.checkmark = love.graphics.newImage("smallcheck.png")
end
function Checkbox.prototype.getPlayer(self)
    return self.p
end
function Checkbox.prototype.getChecked(self)
    return self.checked
end
function Checkbox.prototype.mousePressed(self, x, y, button)
    if button == 1 then
        if (((x >= self.x) and (x <= (self.x + self.width))) and (y >= self.y)) and (y <= (self.y + self.height)) then
            self.checked = not self.checked
        end
    end
end
function Checkbox.prototype.draw(self)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
    if self.checked then
        love.graphics.draw(self.checkmark, self.x, self.y, 0, 0.15, 0.15)
    end
end
local TextInput = __TS__Class()
TextInput.name = "TextInput"
function TextInput.prototype.____constructor(self, x, y)
    self.x = x
    self.y = y
    self.text = ""
end
function TextInput.prototype.mousePressed(self, x, y, button)
    if button == 1 then
    end
end
function TextInput.prototype.draw(self)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(self.text, self.x, self.y)
end
____exports.Gui = __TS__Class()
local Gui = ____exports.Gui
Gui.name = "Gui"
function Gui.prototype.____constructor(self)
    self.drawables = {}
    self.clickables = {}
end
function Gui.prototype.createStartGameGui(self, startCallback)
    local labelP1 = __TS__New(Label, 0, 50, "Player 1:", {0, 0, 0, 1})
    __TS__ArrayPush(self.drawables, labelP1)
    local labelP2 = __TS__New(Label, 0, 95, "Player 2:", {1, 1, 1, 1})
    __TS__ArrayPush(self.drawables, labelP2)
    local labelName = __TS__New(Label, 120, 10, "Name", {1, 1, 0, 1})
    __TS__ArrayPush(self.drawables, labelName)
    local labelAI = __TS__New(Label, 250, 10, "AI Player?", {1, 1, 0, 1})
    __TS__ArrayPush(self.drawables, labelAI)
    local check1 = __TS__New(Checkbox, 275, 50, "p1", false)
    __TS__ArrayPush(self.drawables, check1)
    __TS__ArrayPush(self.clickables, check1)
    local check2 = __TS__New(Checkbox, 275, 95, "p2", true)
    __TS__ArrayPush(self.drawables, check2)
    __TS__ArrayPush(self.clickables, check2)
    local startButton = __TS__New(Button, 155, 435, 126, 40, startCallback)
    __TS__ArrayPush(self.drawables, startButton)
    __TS__ArrayPush(self.clickables, startButton)
    local startLabel = __TS__New(Label, 160, 442, "Start Game", {1, 1, 1, 1})
    __TS__ArrayPush(self.drawables, startLabel)
    local nameP1 = __TS__New(Label, 120, 50, "Ben", {0, 0, 0, 1})
    __TS__ArrayPush(self.drawables, nameP1)
    local nameP2 = __TS__New(Label, 120, 95, "Neb", {1, 1, 1, 1})
    __TS__ArrayPush(self.drawables, nameP2)
end
function Gui.prototype.createEndGameGui(self, restartCallback, mainMenuCallback)
    local restartButton = __TS__New(Button, 0, 435, 138, 40, restartCallback)
    __TS__ArrayPush(self.drawables, restartButton)
    __TS__ArrayPush(self.clickables, restartButton)
    local restartLabel = __TS__New(Label, 0, 442, "Restart Game", {1, 1, 1, 1})
    __TS__ArrayPush(self.drawables, restartLabel)
    local menuButton = __TS__New(Button, 145, 435, 138, 40, mainMenuCallback)
    __TS__ArrayPush(self.drawables, menuButton)
    __TS__ArrayPush(self.clickables, menuButton)
    local menuLabel = __TS__New(Label, 158, 442, "Main Menu", {1, 1, 1, 1})
    __TS__ArrayPush(self.drawables, menuLabel)
end
function Gui.prototype.resetGui(self)
    self.drawables = {}
    self.clickables = {}
end
function Gui.prototype.draw(self)
    __TS__ArrayForEach(
        self.drawables,
        function(____, element)
            element:draw()
        end
    )
end
function Gui.prototype.mousePressed(self, x, y, button)
    __TS__ArrayForEach(
        self.clickables,
        function(____, element)
            element:mousePressed(x, y, button)
        end
    )
end
function Gui.prototype.getParams(self)
    local nameP1 = "Ben"
    local nameP2 = "Neb"
    local humanP1 = true
    local humanP2 = false
    __TS__ArrayForEach(
        self.clickables,
        function(____, element)
            if element.getPlayer then
                if element:getPlayer() == "p1" then
                    humanP1 = element:getChecked()
                elseif element:getPlayer() == "p2" then
                    humanP2 = element:getChecked()
                end
            end
        end
    )
    return {nameP1, humanP1, nameP2, humanP2}
end
return ____exports
