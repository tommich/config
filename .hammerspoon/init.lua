

          
   
-- print("combinations " .. tobits(5))

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
      hs.alert.show(
         "Hello World!",
         {
            textFont= "Comic Sans MS",
            textSize=72,
            fadeOutDuration=1
         }
      )
end)

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

    -- hs.mouse.setRelativePosition(center, nextScreen)
    hs.mouse.setAbsolutePosition(center)
end)

-- Move Mouse to center of previous Monitor
hs.hotkey.bind({"ctrl", "alt", "shift"}, 'left', function()
    local screen = hs.mouse.getCurrentScreen()
    local nextScreen = screen:previous()
    local rect = nextScreen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)

    -- hs.mouse.setRelativePosition(center, nextScreen)
    hs.mouse.setAbsolutePosition(center)
end)





-- move mouse to center of current screen
local mouseCenter = function()
    local screen = hs.mouse.getCurrentScreen()
    -- local nextScreen = screen:previous()
    local rect = screen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)

    -- hs.mouse.setRelativePosition(center, nextScreen)
    hs.mouse.setAbsolutePosition(center)
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'c', mouseCenter)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'k', mouseCenter)



-- move mouse to upper left part of current screen
local mouseUpperLeft = function()
    local screen = hs.mouse.getCurrentScreen()
    local frame = screen:frame()
    
    hs.mouse.setAbsolutePosition({x = frame.x + frame.w/6, y = frame.y + frame.h/6})
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'w', mouseUpperLeft)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'u', mouseUpperLeft)

-- move mouse to upper center part of current screen
local mouseUpperCenter = function()
    local screen = hs.mouse.getCurrentScreen()
    local frame = screen:frame()
    
    hs.mouse.setAbsolutePosition({x = frame.x + frame.w/2, y = frame.y + frame.h/6})
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'i', mouseUpperCenter)

-- move mouse to upper right part of current screen
local mouseUpperRight = function()
    local screen = hs.mouse.getCurrentScreen()
    local frame = screen:frame()
    
    hs.mouse.setAbsolutePosition({x = frame.x + frame.w - frame.w/6, y = frame.y + frame.h/6})
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'r', mouseUpperRight)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'o', mouseUpperRight)



-- move mouse to center left part of current screen
local mouseCenterLeft = function()
    local screen = hs.mouse.getCurrentScreen()
    local frame = screen:frame()
    
    hs.mouse.setAbsolutePosition({x = frame.x + frame.w/6, y = frame.y + frame.h/2})
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'j', mouseCenterLeft)

-- move mouse to center center part of current screen
local mouseCenterCenter = function()
    local screen = hs.mouse.getCurrentScreen()
    local frame = screen:frame()
    
    hs.mouse.setAbsolutePosition({x = frame.x + frame.w/2, y = frame.y + frame.h/2})
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'k', mouseCenterCenter)

-- move mouse to center right part of current screen
local mouseCenterRight = function()
    local screen = hs.mouse.getCurrentScreen()
    local frame = screen:frame()
    
    hs.mouse.setAbsolutePosition({x = frame.x + frame.w - frame.w/6, y = frame.y + frame.h/2})
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'l', mouseCenterRight)



-- move mouse to lower left part of current screen
local mouseLowerLeft = function()
    local screen = hs.mouse.getCurrentScreen()
    local frame = screen:frame()
    
    hs.mouse.setAbsolutePosition({x = frame.x + frame.w/6, y = frame.y + frame.h - frame.h/6})
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'x', mouseLowerLeft)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'm', mouseLowerLeft)

-- move mouse to lower center part of current screen
local mouseLowerCenter = function()
    local screen = hs.mouse.getCurrentScreen()
    local frame = screen:frame()
    
    hs.mouse.setAbsolutePosition({x = frame.x + frame.w - frame.w/2, y = frame.y + frame.h - frame.h/6})
end
-- doesn't work - used by macos
-- hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, ',', mouseLowerCenter)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, '[', mouseLowerCenter)

-- move mouse to lower right part of current screen
local mouseLowerRight = function()
    local screen = hs.mouse.getCurrentScreen()
    local frame = screen:frame()
    
    hs.mouse.setAbsolutePosition({x = frame.x + frame.w - frame.w/6, y = frame.y + frame.h - frame.h/6})
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'v', mouseLowerRight)
-- doesn't work - used by macos
-- hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, '.', mouseLowerRight)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, ']', mouseLowerRight)




-- move mouse left a quarter of a screen
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 's', function()
    local screen = hs.mouse.getCurrentScreen()
    local frame = screen:frame()
    local current_pos = hs.mouse.absolutePosition()
    print("current mouse x: " .. current_pos.x)
    print("current mouse y: " .. current_pos.y)
    
    hs.mouse.setAbsolutePosition({x = current_pos.x - frame.w/4, y = current_pos.y})

end)

-- move mouse right a quarter of a screen
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'f', function()
    local screen = hs.mouse.getCurrentScreen()
    local frame = screen:frame()
    local current_pos = hs.mouse.absolutePosition()
    print("current mouse x: " .. current_pos.x)
    print("current mouse y: " .. current_pos.y)
    
    hs.mouse.setAbsolutePosition({x = current_pos.x + frame.w/4, y = current_pos.y})

end)

-- move mouse up a quarter of a screen
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'e', function()
    local screen = hs.mouse.getCurrentScreen()
    local frame = screen:frame()
    local current_pos = hs.mouse.absolutePosition()
    print("current mouse x: " .. current_pos.x)
    print("current mouse y: " .. current_pos.y)
    
    hs.mouse.setAbsolutePosition({x = current_pos.x, y = current_pos.y - frame.h/4})

end)

-- move mouse down a quarter of a screen
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'd', function()
    local screen = hs.mouse.getCurrentScreen()
    local frame = screen:frame()
    local current_pos = hs.mouse.absolutePosition()
    print("current mouse x: " .. current_pos.x)
    print("current mouse y: " .. current_pos.y)
    
    hs.mouse.setAbsolutePosition({x = current_pos.x, y = current_pos.y + frame.h/4})

    print("x: " .. frame.x)

end)

-- move mouse to upper-left corner
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'z', function()
    local screen = hs.mouse.getCurrentScreen()
    local max = screen:frame()
    
    hs.mouse.setAbsolutePosition({x = max.x+max.w/4, y = max.y})

end)

-- get screen positions
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'p', function()
    local positions = hs.screen.screenPositions()
end)
