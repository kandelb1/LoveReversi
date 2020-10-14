--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
____exports.TurnQueue = __TS__Class()
local TurnQueue = ____exports.TurnQueue
TurnQueue.name = "TurnQueue"
function TurnQueue.prototype.____constructor(self)
    self.q = {}
end
function TurnQueue.prototype.push(self, val)
    __TS__ArrayPush(self.q, val)
end
function TurnQueue.prototype.pop(self)
    local v = __TS__ArrayShift(self.q)
    if v == nil then
        error(
            __TS__New(Error, "Popping when the turn queue is empty."),
            0
        )
    end
    return v
end
function TurnQueue.prototype.top(self)
    local v = self.q[1]
    if v == nil then
        error(
            __TS__New(Error, "Calling top() when the queue is empty."),
            0
        )
    end
    return v
end
function TurnQueue.prototype.clear(self)
    self.q = {}
end
return ____exports
