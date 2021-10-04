

          
   
-- print("combinations " .. tobits(5))

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
--       hs.alert.show(
--          "Hello World!",
--          {
--             textFont= "Comic Sans MS",
--             textSize=72,
--             fadeOutDuration=1
--          }
--       )
-- end)

-- Magnet replacement bindings

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "l", function()
	hs.window.focusedWindow():moveOneScreenEast()
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "h", function()
	hs.window.focusedWindow():moveOneScreenWest()
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "k", function()
  -- size focused window to size of desktop
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)

-- resizing window 

--hs.hotkey.bind({"ctrl", "alt", "cmd", "shift"}, "l", function()
--  -- size focused window to right half of display
--  local win = hs.window.focusedWindow()
--  local f = win:frame()
--  local screen = win:screen()
--  local max = screen:frame()
--
--  f.x = max.x + (max.w / 2)
--  f.y = max.y
--  f.w = max.w / 2
--  f.h = max.h
--  win:setFrame(f)
--end)
--
--hs.hotkey.bind({"ctrl", "alt", "cmd", "shift"}, "h", function()
--  -- size focused window to left half of display
--  local win = hs.window.focusedWindow()
--  local f = win:frame()
--  local screen = win:screen()
--  local max = screen:frame()
--
--  f.x = max.x
--  f.y = max.y
--  f.w = max.w / 2
--  f.h = max.h
--  win:setFrame(f)
--end)
--
--hs.hotkey.bind({"ctrl", "alt", "cmd", "shift"}, "k", function()
--  -- size focused window to top half of display
--  local win = hs.window.focusedWindow()
--  local f = win:frame()
--  local screen = win:screen()
--  local max = screen:frame()
--
--  f.x = max.x
--  f.y = max.y
--  f.w = max.w
--  f.h = max.h / 2
--  win:setFrame(f)
--end)
--
--hs.hotkey.bind({"ctrl", "alt", "cmd", "shift"}, "j", function()
--  -- size focused window to bottom half of display
--  local win = hs.window.focusedWindow()
--  local f = win:frame()
--  local screen = win:screen()
--  local max = screen:frame()
--
--  f.x = max.x
--  f.y = max.y + (max.h / 2)
--  f.w = max.w
--  f.h = max.h / 2
--  win:setFrame(f)
--end)

local movementFn = function(modifier, direction) 
  print(direction) 
  print("let the record show that " .. direction .. " was pressed")
  hs.eventtap.keyStroke(modifier, direction, 0) 
end

downfn = function() print'let the record show that J was pressed'; hs.eventtap.keyStroke({}, 'down', 0) end
upfn = function() print'let the record show that K was pressed'; hs.eventtap.keyStroke({}, 'up', 0) end
leftfn = function() print'let the record show that H was pressed'; hs.eventtap.keyStroke({}, 'left', 0) end
rightfn = function() print'let the record show that L was pressed'; hs.eventtap.keyStroke({}, 'right', 0) end

enterfn = function() print'let the record show that O was pressed'; hs.eventtap.keyStroke({}, 'return', 0) end

vim_mode = hs.hotkey.modal.new({"ctrl", "alt", "cmd"}, ';')
function vim_mode:entered() hs.alert.show('Entered vim mode', {}, 0.5) end
function vim_mode:exited()  hs.alert.show('Exited vim mode', {}, 0.5)  end

--local all_keys = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', 'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '[', ']', '\\', 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ';', '\'', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', ',', '.', '/'}
--local all_keys = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', 'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'P', '[', ']', '\\', 'A', 'S', 'D', 'F', 'G', '\'', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', ',', '.', '/'}

--hs.fnutils.each(all_keys, function(key) vim_mode:bind({}, key, function() hs.alert.show('vim mode', {}, 0.3) end) end)
--hs.fnutils.each(all_keys, function(key) vim_mode:bind({'shift'}, key, function() hs.alert.show('vim mode', {}, 0.3) end) end)

vim_mode:bind({}, ';', function() vim_mode:exit() end)
vim_mode:bind({}, 'i', function() vim_mode:exit() end)
vim_mode:bind({}, 'o', enterfn)
--vim_mode:bind({}, 'q', function() end)
-- todo this makes 'o' recursive
-- vim_mode:bind({}, 'return', function() vim_mode:exit() enterfn() end)

local bindModalAndKeyToDirection = function(modal, key, direction) 
    vim_mode:bind(modal, key, {}, function() print'binding inside' movementFn(modal, direction) end, {}, function() print'binding inside' movementFn(modal, direction) end)
end
  
local combineModalAndKeys = function(modal)
  hs.fnutils.each(
    {
      { key='l', direction='right' }, 
      { key='h', direction='left' },
      { key='j', direction='down' },
      { key='k', direction='up' }
    }, function(hotkey)
      print'binding'
      bindModalAndKeyToDirection(modal, hotkey.key, hotkey.direction)
    end
  )
end

--local all_modal_combinations = {{}, {'shift'}, {'option'}, {'ctrl'}, {'cmd'}, {'shift', 'option'}, {'shift', 'ctrl'}, {'shift', 'cmd'}, {'option', 'ctrl'}, {'option', 'cmd'}, {'ctrl', 'cmd'}, {'shift', 'option', 'ctrl'}, {'shift', 'option', 'cmd'}, {'shift', 'ctrl', 'cmd'}, {'option', 'ctrl', 'cmd'}, {'shift', 'option', 'ctrl', 'cmd'}}

-- hs.fnutils.each(all_modal_combinations, function(modal) combineModalAndKeys(modal) end)

--hs.fnutils.each({ {}, {'shift'}, {'option'}, {'shift', 'option'}, {'cmd'}, {'cmd', 'shift'} }, function(modal) combineModalAndKeys(modal) end)

--function tobits(num)
--    local t={}
--    while num>0 do
--        rest=num%2
--        t[#t+1]=(rest == 1)
--        num=(num-rest)//2
--    end
--    return t
--end
--
----for i,v in ipairs(tobits(5)) do print("printing " .. i .. " " .. v) end                     
--for i,v in ipairs(tobits(5)) do print(v) end                     
--
--local all_modal_keys = {'shift', 'ctrl', 'option', 'cmd'} 
--
--count = 0
--for _ in pairs(all_modal_keys) do count = count + 1 end
--print("count " .. count)
--local modal_keys_count = count
--
--for i=1,count*2 do 
--  for i,v in ipairs(tobits(i)) do print(v) end                     
--  local boolarray = tobits(i)
--
--  print("-----")
--end

-- Move Mouse to center of next Monitor
hs.hotkey.bind({"ctrl", "alt", "shift"}, 'right', function()
    local screen = hs.mouse.getCurrentScreen()
    local nextScreen = screen:next()
    local rect = nextScreen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)
    hs.mouse.setAbsolutePosition(center)
    mouseHighlight()
end)

-- Move Mouse to center of previous Monitor
hs.hotkey.bind({"ctrl", "alt", "shift"}, 'left', function()
    local screen = hs.mouse.getCurrentScreen()
    local nextScreen = screen:previous()
    local rect = nextScreen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)
    hs.mouse.setAbsolutePosition(center)
    mouseHighlight()
end)

-- Move Mouse to center of first screen
hs.hotkey.bind({"ctrl", "alt", "shift", "cmd"}, '1', function()
    local screen = hs.screen.primaryScreen()
    local nextScreen = screen:previous():previous()
    local rect = nextScreen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)
    hs.mouse.setAbsolutePosition(center)
    mouseHighlight()
end)

-- Move Mouse to center of second screen
hs.hotkey.bind({"ctrl", "alt", "shift", "cmd"}, '2', function()
    local screen = hs.screen.primaryScreen()
    local nextScreen = screen:previous()
    local rect = nextScreen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)
    hs.mouse.setAbsolutePosition(center)
    mouseHighlight()
end)


-- Move Mouse to center of third screen
hs.hotkey.bind({"ctrl", "alt", "shift", "cmd"}, '3', function()
    local screen = hs.screen.primaryScreen()
    local nextScreen = screen
    local rect = nextScreen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)
    hs.mouse.setAbsolutePosition(center)
    mouseHighlight()
end)

-- move mouse to center of current screen
local mouseCenter = function()
    local screen = hs.mouse.getCurrentScreen()
    local rect = screen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)
    hs.mouse.setAbsolutePosition(center)
    mouseHighlight()
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'c', mouseCenter)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'k', mouseCenter)

local moveMouseToScreenPart = function(arg)
    local screen = hs.mouse.getCurrentScreen()
    local frame = screen:frame()
    hs.mouse.setAbsolutePosition({x = frame.x + arg.horizontal * frame.w, y = frame.y + arg.vertical * frame.h})
    mouseHighlight()
end

local lowEdge = 1/6
local center = 3/6
local highEdge = 5/6

-- move mouse to upper left part of current screen
local moveMouseInScreenUpperLeft = function()
    moveMouseToScreenPart{horizontal = lowEdge, vertical = lowEdge}
end
-- hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'w', moveMouseInScreenUpperLeft)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'u', moveMouseInScreenUpperLeft)

-- move mouse to upper center part of current screen
local moveMouseInScreenUpperCenter = function()
    moveMouseToScreenPart{horizontal = center, vertical = lowEdge}
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'i', moveMouseInScreenUpperCenter)

-- move mouse to upper right part of current screen
local moveMouseInScreenUpperRight = function()
    moveMouseToScreenPart{horizontal = highEdge, vertical = lowEdge}
end
-- hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'r', moveMouseInScreenUpperRight)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'o', moveMouseInScreenUpperRight)



-- move mouse to center left part of current screen
local moveMouseInScreenCenterLeft = function()
    moveMouseToScreenPart{horizontal = lowEdge, vertical = center}
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'j', moveMouseInScreenCenterLeft)

-- move mouse to center center part of current screen
local moveMouseInScreenCenterCenter = function()
    moveMouseToScreenPart{horizontal = center, vertical = center}
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'k', moveMouseInScreenCenterCenter)

-- move mouse to center right part of current screen
local moveMouseInScreenCenterRight = function()
    moveMouseToScreenPart{horizontal = highEdge, vertical = center}
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'l', moveMouseInScreenCenterRight)



-- move mouse to lower left part of current screen
local moveMouseInScreenLowerLeft = function()
    moveMouseToScreenPart{horizontal = lowEdge, vertical = highEdge}
end
-- hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'x', moveMouseInScreenLowerLeft)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'm', moveMouseInScreenLowerLeft)

-- move mouse to lower center part of current screen
local moveMouseInScreenLowerCenter = function()
	moveMouseToScreenPart{horizontal = center, vertical = highEdge}
end
-- doesn't work - used by macos
-- hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, ',', moveMouseInScreenLowerCenter)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, '[', moveMouseInScreenLowerCenter)

-- move mouse to lower right part of current screen
local moveMouseInScreenLowerRight = function()
    moveMouseToScreenPart{horizontal = highEdge, vertical = highEdge}
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'v', moveMouseInScreenLowerRight)
-- doesn't work - used by macos
-- hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, '.', moveMouseInScreenLowerRight)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, ']', moveMouseInScreenLowerRight)

local move_mouse_relative = function(direction, magnitude)
    local screen = hs.mouse.getCurrentScreen()
    local frame = screen:frame()
    local current_pos = hs.mouse.absolutePosition()
    hs.mouse.setAbsolutePosition({x = current_pos.x + direction.horizontal * frame.w * magnitude, y = current_pos.y + direction.vertical * frame.h * magnitude})
    mouseHighlight()
end

local small_bit = 1/12

local direction_left = {horizontal = -1, vertical = 0}
local direction_right = {horizontal = 1, vertical = 0}

local direction_up_left = {horizontal = -1, vertical = -1}
local direction_up_right = {horizontal = 1, vertical = -1}
local direction_up = {horizontal = 0, vertical = -1}

local direction_down = {horizontal = 0, vertical = 1}
local direction_down_left = {horizontal = -1, vertical = 1}
local direction_down_right = {horizontal = 1, vertical = 1}

-- move mouse left
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 's', function () move_mouse_relative(direction_left, small_bit) end)

-- move mouse right
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'f', function () move_mouse_relative(direction_right, small_bit) end)

-- move mouse up-left
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'w', function () move_mouse_relative(direction_up_left, small_bit) end)

-- move mouse up-right
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'r', function () move_mouse_relative(direction_up_right, small_bit) end)

-- move mouse up
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'e', function () move_mouse_relative(direction_up, small_bit) end)


-- move mouse down
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'c', function () move_mouse_relative(direction_down, small_bit) end)

-- move mouse down
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'd', function () move_mouse_relative(direction_down, small_bit) end)

-- move mouse down-left
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'x', function () move_mouse_relative(direction_down_left, small_bit) end)

-- move mouse down-right
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'v', function () move_mouse_relative(direction_down_right, small_bit) end)

-- get screen positions
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'p', function()
    local positions = hs.screen.screenPositions()
end)

---- Mouse-related stuff

-- Find my mouse pointer

local mouseCircle = nil
local mouseCircleTimer = nil

local showMouseJumpGuides = true

function mouseHighlight()
    -- Delete an existing highlight if it exists
    if mouseCircle then
        mouseCircle:delete()
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    -- Get the current co-ordinates of the mouse pointer
    mousepoint = hs.mouse.getAbsolutePosition ()
    -- Prepare a big red circle around the mouse pointer
    mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-40, mousepoint.y-40, 80, 80))
    mouseCircle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
    mouseCircle:setFill(false)
    mouseCircle:setStrokeWidth(5)
    mouseCircle:show()

    -- Set a timer to delete the circle after x seconds
    mouseCircleTimer = hs.timer.doAfter(0.2, clearHighlight)
end

function clearHighlight()
  mouseCircle:delete()
  mouseCircle = nil
end

--HYPER TEST


hyper_mode = hs.hotkey.modal.new({}, 'F18')
function hyper_mode:entered() hs.alert.show('Entered hyper_mode', {}, 0.5) end
function hyper_mode:exited()  hs.alert.show('Exited hyper_mode', {}, 0.5)  end
hyper_mode:bind({}, 'F18', function() hyper_mode:exit() end)
hyper_mode:bind({"ctrl", "alt", "shift", 'command'}, 'h', function() hs.alert.show('Hyper hello world!', {}, 0.5) end)
