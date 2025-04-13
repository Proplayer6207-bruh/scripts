name = "Stopwatch"
description = "Stopwatch that toggles and restarts with key press of equal sign.you can change the KEY with text editors"
author = "Pro player"

local startTime = os.time()
local elapsedTime = 0
local toggleCount = 0

local KEY = "=" 
local GUI_INDEX = 0
local running = false

onEvent("KeyEvent", function(key, action)
    if action == 1 and util.keyToString(key) == KEY then
        toggleCount = toggleCount + 1

        if toggleCount == 1 then
            startTime = os.time()
            running = true

        elseif toggleCount == 2 then
            elapsedTime = elapsedTime + (os.time() - startTime)
            running = false
            startTime = nil

        elseif toggleCount >= 3 then
            elapsedTime = 0
            toggleCount = 0
            running = false
        end
    end
end)

onEvent("RenderEvent", function()
    local total = running and (elapsedTime + (os.time() - startTime)) or elapsedTime
    local h = total // 3600
    local m = (total % 3600) // 60
    local s = total % 60
    gui.render(string.format("%2dh%2dm%2ds",h,m,s), GUI_INDEX)
end)
