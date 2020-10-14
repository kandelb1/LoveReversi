--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____GameManager = require("GameManager")
local GameManager = ____GameManager.GameManager
local ____Test = require("Test")
local Test = ____Test.Test
local gm
local runTests
runTests = function()
    local t = __TS__New(Test)
    t:runTests()
    print("Quitting...")
    love.event.quit()
end
love.load = function(arg)
    do
        local i = 0
        while i < #arg do
            local argument = __TS__StringTrim(arg[i + 1])
            if argument == "--test" then
                runTests(nil)
            end
            i = i + 1
        end
    end
    love.graphics.setBackgroundColor(0.16, 0.6, 0.14)
    love.graphics.setFont(
        love.graphics.newFont(20)
    )
    gm = __TS__New(GameManager)
end
love.update = function(dt)
    gm:update(dt)
end
love.draw = function()
    gm:draw()
end
love.mousepressed = function(x, y, button, isTouch)
    gm:mousePressed(x, y, button)
end
return ____exports
