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

hs.hotkey.bind({"ctrl", "alt", "cmd", "shift"}, "l", function()
  -- size focused window to right half of display
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"ctrl", "alt", "cmd", "shift"}, "h", function()
  -- size focused window to left half of display
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"ctrl", "alt", "cmd", "shift"}, "k", function()
  -- size focused window to top half of display
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"ctrl", "alt", "cmd", "shift"}, "j", function()
  -- size focused window to bottom half of display
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

local movementFn = function(modifier, direction) 
  print(direction) 
  print("let the record show that" .. direction .. "was pressed")
  hs.eventtap.keyStroke(modifier, direction, 0) 
end

downfn = function() print'let the record show that J was pressed'; hs.eventtap.keyStroke({}, 'down', 0) end
upfn = function() print'let the record show that K was pressed'; hs.eventtap.keyStroke({}, 'up', 0) end
leftfn = function() print'let the record show that H was pressed'; hs.eventtap.keyStroke({}, 'left', 0) end
rightfn = function() print'let the record show that L was pressed'; hs.eventtap.keyStroke({}, 'right', 0) end

hjkl = hs.hotkey.modal.new('cmd-shift', 'd')
function hjkl:entered() hs.alert'Entered hjkl mode' end
function hjkl:exited()  hs.alert'Exited hjkl mode'  end
hjkl:bind({}, 'escape', function() hjkl:exit() end)

local bindModalAndKeyToDirection = function(modal, key, direction) 
    hjkl:bind(modal, key, {}, function() movementFn(modal, direction) end, {}, function() movementFn(modal, direction) end)
end
  
local combineModalAndKeys = function(modal)
  hs.fnutils.each(
    {
      { key='L', direction='right' }, 
      { key='H', direction='left' },
      { key='J', direction='down' },
      { key='K', direction='up' }
    }, function(hotkey)
      bindModalAndKeyToDirection(modal, hotkey.key, hotkey.direction)
    end
  )
end

hs.fnutils.each({ {}, {'shift'}, {'option'}, {'shift', 'option'}, {'cmd'}, {'cmd', 'shift'} }, function(modal) combineModalAndKeys(modal) end)
