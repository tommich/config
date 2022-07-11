--WINDOW SWITCHER
-- set up your windowfilter
switcher = hs.window.switcher.new() -- default windowfilter: only visible windows, all Spaces
--switcher_space = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{}) -- include minimized/hidden windows, current Space only
--switcher_browsers = hs.window.switcher.new{'Safari','Google Chrome'} -- specialized switcher for your dozens of browser windows :)

-- bind to hotkeys; WARNING: at least one modifier key is required!
hs.hotkey.bind('alt','tab',function()switcher:next()end)
hs.hotkey.bind('alt-shift','tab',function()switcher:previous()end)


hs.window.animationDuration = 0
--WINDOW SWITCHER


--hello world
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

local get_center_of_screen = function(screen)
    local rect = screen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)
    return center
end

local get_center_of_mouse_screen = function()
    local screen = hs.mouse.getCurrentScreen()
    return get_center_of_screen(screen)
end

local big_magnitude = 2/6
local moving_center = get_center_of_mouse_screen() 
local moving_magnitude = big_magnitude 


hs.hotkey.bind({"cmd", "ctrl", "alt"}, "l", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen()
  win:moveOneScreenEast()
  local nextScreen = screen:next()
  local center = get_center_of_screen(nextScreen)
  hs.mouse.absolutePosition(center)
  mouseHighlight()
  moving_center = center
  moving_magnitude = big_magnitude
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "h", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen()
  win:moveOneScreenWest()
  local nextScreen = screen:previous()
  local center = get_center_of_screen(nextScreen)
  hs.mouse.absolutePosition(center)
  mouseHighlight()
  moving_center = center
  moving_magnitude = big_magnitude
end)

-- resizing window 
local fullscreen = function()
  -- size focused window to size of desktop
  local win = hs.window.focusedWindow()
  local new_frame = win:frame()
  local screen = win:screen()
  local screen_frame = screen:frame()

  new_frame.x = screen_frame.x
  new_frame.y = screen_frame.y
  new_frame.w = screen_frame.w
  new_frame.h = screen_frame.h
  win:setFrame(new_frame)
end

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "k", fullscreen)
hs.hotkey.bind({"ctrl", "alt", "cmd", "shift"}, "up", fullscreen)


hs.hotkey.bind({"ctrl", "alt", "cmd", "shift"}, "right", function()
  -- size focused window to right half of display
  local win = hs.window.focusedWindow()
  local new_frame = win:frame()
  local screen = win:screen()
  local screen_frame = screen:frame()

  new_frame.x = screen_frame.x + (screen_frame.w / 2)
  new_frame.y = screen_frame.y
  new_frame.w = screen_frame.w / 2
  new_frame.h = screen_frame.h
  win:setFrame(new_frame)
end)

hs.hotkey.bind({"ctrl", "alt", "cmd", "shift"}, "left", function()
  -- size focused window to left half of display
  local win = hs.window.focusedWindow()
  local new_frame = win:frame()
  local screen = win:screen()
  local screen_frame = screen:frame()

  new_frame.x = screen_frame.x
  new_frame.y = screen_frame.y
  new_frame.w = screen_frame.w / 2
  new_frame.h = screen_frame.h
  win:setFrame(new_frame)
end)

hs.hotkey.bind({"ctrl", "alt", "cmd", "shift"}, "up", function()
  -- size focused window to top half of display
  local win = hs.window.focusedWindow()
  local new_frame = win:frame()
  local screen = win:screen()
  local screen_frame = screen:frame()

  new_frame.x = screen_frame.x
  new_frame.y = screen_frame.y
  new_frame.w = screen_frame.w
  new_frame.h = screen_frame.h / 2
  win:setFrame(new_frame)
end)

hs.hotkey.bind({"ctrl", "alt", "cmd", "shift"}, "down", function()
  -- size focused window to bottom half of display
  local win = hs.window.focusedWindow()
  local new_frame = win:frame()
  local screen = win:screen()
  local screen_frame = screen:frame()

  new_frame.x = screen_frame.x
  new_frame.y = screen_frame.y + (screen_frame.h / 2)
  new_frame.w = screen_frame.w
  new_frame.h = screen_frame.h / 2
  win:setFrame(new_frame)
end)

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

--local all_modal_keys = {'shift', 'ctrl', 'option', 'cmd'} 

hs.hotkey.bind({"ctrl", "alt", "shift"}, 'right', function()
    local screen = hs.mouse.getCurrentScreen()
    local nextScreen = screen:next()
    local center = get_center_of_screen(nextScreen)
    hs.mouse.absolutePosition(center)
    mouseHighlight()
    moving_center = center
    moving_magnitude = big_magnitude
end)

hs.hotkey.bind({"ctrl", "alt", "shift"}, 'left', function()
    local screen = hs.mouse.getCurrentScreen()
    local nextScreen = screen:previous()
    local center = get_center_of_screen(nextScreen)
    hs.mouse.absolutePosition(center)
    mouseHighlight()
    moving_center = center
    moving_magnitude = big_magnitude
end)

hs.hotkey.bind({"ctrl", "alt", "shift", "cmd"}, '1', function()
    local screen = hs.screen.primaryScreen()
    local nextScreen = screen:previous():previous()
    local center = get_center_of_screen(nextScreen)
    hs.mouse.absolutePosition(center)
    mouseHighlight()
    moving_center = center
    moving_magnitude = big_magnitude
  
    local frame = nextScreen:frame()
    local margined_frame = {x = frame.x + 25, y = frame.y + 40, w = frame.w - 50, h = frame.h - 80}
    jumpGuidesHighlight(margined_frame.w * moving_magnitude, margined_frame.h * moving_magnitude)
end)

hs.hotkey.bind({"ctrl", "alt", "shift", "cmd"}, '2', function()
    local screen = hs.screen.primaryScreen()
    local nextScreen = screen:previous()
    local center = get_center_of_screen(nextScreen)
    hs.mouse.absolutePosition(center)
    mouseHighlight()
    moving_center = center
    moving_magnitude = big_magnitude

    local frame = nextScreen:frame()
    local margined_frame = {x = frame.x + 25, y = frame.y + 40, w = frame.w - 50, h = frame.h - 80}
    jumpGuidesHighlight(margined_frame.w * moving_magnitude, margined_frame.h * moving_magnitude)
end)


hs.hotkey.bind({"ctrl", "alt", "shift", "cmd"}, '3', function()
    local screen = hs.screen.primaryScreen()
    local nextScreen = screen
    local center = get_center_of_screen(nextScreen)
    hs.mouse.absolutePosition(center)
    mouseHighlight()
    moving_center = center
    moving_magnitude = big_magnitude

    local frame = nextScreen:frame()
    local margined_frame = {x = frame.x + 25, y = frame.y + 40, w = frame.w - 50, h = frame.h - 80}
    jumpGuidesHighlight(margined_frame.w * moving_magnitude, margined_frame.h * moving_magnitude)
end)

local mouse_center = function()
    local center = get_center_of_mouse_screen()
    hs.mouse.absolutePosition(center)
    mouseHighlight()
    moving_center = center
    moving_magnitude = big_magnitude

    local screen = hs.mouse.getCurrentScreen()
    local frame = screen:frame()
    local margined_frame = {x = frame.x + 25, y = frame.y + 40, w = frame.w - 50, h = frame.h - 80}
    jumpGuidesHighlight(margined_frame.w * moving_magnitude, margined_frame.h * moving_magnitude)
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'c', mouse_center)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'k', mouse_center)

local moveMouseToScreenPart = function(arg)
    local screen = hs.mouse.getCurrentScreen()
    local frame = screen:frame()
    hs.mouse.absolutePosition({x = frame.x + arg.horizontal * frame.w, y = frame.y + arg.vertical * frame.h})
    mouseHighlight()
end

local move_mouse_relative_to_point = function(point, direction, magnitude)
    local screen = hs.mouse.getCurrentScreen()
    local frame = screen:frame()
    local margined_frame = {x = frame.x + 25, y = frame.y + 40, w = frame.w - 50, h = frame.h - 80}

    --local not_framed_point = {x = point.x + direction.horizontal * frame.w * magnitude, y = point.y + direction.vertical * frame.h * magnitude}
    local framed_point = {x = point.x + direction.horizontal * margined_frame.w * magnitude, y = point.y + direction.vertical * margined_frame.h * magnitude}

    new_point = not_framed_point
    new_point = framed_point

    hs.mouse.absolutePosition(new_point)
    mouseHighlight()
    moving_center = new_point
    moving_magnitude = magnitude/2
    jumpGuidesHighlight(margined_frame.w * moving_magnitude, margined_frame.h * moving_magnitude)
end

local move_mouse_relative_to_current_position = function(direction, magnitude)
    local current_pos = hs.mouse.absolutePosition()
    move_mouse_relative_to_point(current_pos, direction, magnitude)
end

local move_mouse_relative_to_center = function(direction, magnitude)
    local center = get_center_of_mouse_screen()
    --local current_pos = hs.mouse.absolutePosition()
    move_mouse_relative_to_point(center, direction, magnitude)
end


local direction_left = {horizontal = -1, vertical = 0}
local direction_right = {horizontal = 1, vertical = 0}

local direction_up_left = {horizontal = -1, vertical = -1}
local direction_up_right = {horizontal = 1, vertical = -1}
local direction_up = {horizontal = 0, vertical = -1}

local direction_down = {horizontal = 0, vertical = 1}
local direction_down_left = {horizontal = -1, vertical = 1}
local direction_down_right = {horizontal = 1, vertical = 1}

local direction_zero = {horizontal = 0, vertical = 0}

local moveMouseInScreenUpperLeft = function()
    move_mouse_relative_to_center(direction_up_left, moving_magnitude)
end
-- hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'w', moveMouseInScreenUpperLeft)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'u', function() move_mouse_relative_to_point(moving_center, direction_up_left, moving_magnitude) end)

local moveMouseInScreenUpperCenter = function()
    move_mouse_relative_to_center(direction_up, moving_magnitude)
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'i', function() move_mouse_relative_to_point(moving_center, direction_up, moving_magnitude) end)

local moveMouseInScreenUpperRight = function()
    move_mouse_relative_to_center(direction_up_right, moving_magnitude)
end
-- hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'r', moveMouseInScreenUpperRight)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'o', function() move_mouse_relative_to_point(moving_center, direction_up_right, moving_magnitude) end)

local moveMouseInScreenCenterLeft = function()
    move_mouse_relative_to_center(direction_left, moving_magnitude)
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'j', function() move_mouse_relative_to_point(moving_center, direction_left, moving_magnitude) end)

local moveMouseInScreenCenterCenter = function()
    move_mouse_relative_to_center(direction_zero, moving_magnitude)
end
--hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'k', function() move_mouse_relative_to_center(direction_zero, moving_magnitude) end)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'k', function() mouse_center() end)

local moveMouseInScreenCenterRight = function()
    move_mouse_relative_to_center(direction_right, moving_magnitude)
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'l', function() move_mouse_relative_to_point(moving_center, direction_right, moving_magnitude) end)



local moveMouseInScreenLowerLeft = function()
    move_mouse_relative_to_center(direction_down_left, moving_magnitude)
end
-- hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'x', moveMouseInScreenLowerLeft)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'm', function() move_mouse_relative_to_point(moving_center, direction_down_left, moving_magnitude) end)

local moveMouseInScreenLowerCenter = function()
    move_mouse_relative_to_center(direction_down, moving_magnitude)
end
-- doesn't work - used by macos
-- hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, ',', moveMouseInScreenLowerCenter)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, '[', function() move_mouse_relative_to_point(moving_center, direction_down, moving_magnitude) end)

local moveMouseInScreenLowerRight = function()
    move_mouse_relative_to_center(direction_down_right, moving_magnitude)
end
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'v', function() move_mouse_relative_to_point(moving_center, direction_down_right, moving_magnitude) end)
-- doesn't work - used by macos
-- hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, '.', moveMouseInScreenLowerRight)
hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, ']', function() move_mouse_relative_to_point(moving_center, direction_down_right, moving_magnitude) end)



local small_bit = 1/12

hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 's', function() move_mouse_relative_to_current_position(direction_left, small_bit) end)

hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'f', function() move_mouse_relative_to_current_position(direction_right, small_bit) end)

hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'w', function() move_mouse_relative_to_current_position(direction_up_left, small_bit) end)

hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'r', function() move_mouse_relative_to_current_position(direction_up_right, small_bit) end)

hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'e', function() move_mouse_relative_to_current_position(direction_up, small_bit) end)

hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'c', function() move_mouse_relative_to_current_position(direction_down, small_bit) end)

hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'd', function() move_mouse_relative_to_current_position(direction_down, small_bit) end)

hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'x', function() move_mouse_relative_to_current_position(direction_down_left, small_bit) end)

hs.hotkey.bind({"ctrl", "alt", "shift", 'command'}, 'v', function() move_mouse_relative_to_current_position(direction_down_right, small_bit) end)


local screen = hs.mouse.getCurrentScreen()
local rect = screen:fullFrame()
local center = hs.geometry.rectMidPoint(rect)


-- Find my mouse pointer
local mouseCircle = nil
local mouseCircleTimer = nil

function mouseHighlight()
    -- Delete an existing highlight if it exists
    if mouseCircle then
        mouseCircle:delete()
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    -- Get the current co-ordinates of the mouse pointer
    mousepoint = hs.mouse.absolutePosition()
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

local guides = nil
local guidesTimer = nil


function jumpGuidesHighlight(horizontalDistance, verticalDistance)
    -- Delete an existing highlight if it exists
    if guides then
        clearGuidesHighlight()
        if guidesTimer then
            guidesTimer:stop()
        end
    end
    -- Get the current co-ordinates of the mouse pointer
    mousepoint = hs.mouse.absolutePosition()

    guides = {}

    direction_left = {horizontal = -1, vertical = 0}
    direction_right = {horizontal = 1, vertical = 0}
   
    direction_up_left = {horizontal = -1, vertical = -1}
    direction_up_right = {horizontal = 1, vertical = -1}
    direction_up = {horizontal = 0, vertical = -1}
   
    direction_down = {horizontal = 0, vertical = 1}
    direction_down_left = {horizontal = -1, vertical = 1}
    direction_down_right = {horizontal = 1, vertical = 1}

    distance = {horizontal = horizontalDistance, vertical = verticalDistance}

    guides.left = drawSmallBlueCircleRelativeToPoint(mousepoint, direction_left, distance)
    guides.right = drawSmallBlueCircleRelativeToPoint(mousepoint, direction_right, distance)
    guides.up_left = drawSmallBlueCircleRelativeToPoint(mousepoint, direction_up_left, distance)
    guides.up_right = drawSmallBlueCircleRelativeToPoint(mousepoint, direction_up_right, distance)
    guides.up = drawSmallBlueCircleRelativeToPoint(mousepoint, direction_up, distance)
    guides.down = drawSmallBlueCircleRelativeToPoint(mousepoint, direction_down, distance)
    guides.down_left = drawSmallBlueCircleRelativeToPoint(mousepoint, direction_down_left, distance)
    guides.down_right = drawSmallBlueCircleRelativeToPoint(mousepoint, direction_down_right, distance)

    guidesTimer = hs.timer.doAfter(1.0, clearGuidesHighlight)
end

function drawSmallBlueCircleRelativeToPoint(point, direction, distance)
    circle = hs.drawing.circle(hs.geometry.rect(point.x - 3 + distance.horizontal * direction.horizontal, point.y - 3 + distance.vertical * direction.vertical, 6, 6))
    circle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
    circle:setFill(true)
    circle:setFillColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
    circle:show()
    return circle
end

function clearGuidesHighlight()
  guides.left:delete()
  guides.right:delete()
  guides.up_left:delete()
  guides.up_right:delete()
  guides.up:delete()
  guides.down:delete()
  guides.down_left:delete()
  guides.down_right:delete()
  guides = nil
end



--HYPER TEST

-- hyper_mode = hs.hotkey.modal.new({}, 'F18')
-- function hyper_mode:entered() hs.alert.show('Entered hyper_mode', {}, 0.5) end
-- function hyper_mode:exited()  hs.alert.show('Exited hyper_mode', {}, 0.5)  end
-- hyper_mode:bind({}, 'F18', function() hyper_mode:exit() end)
-- hyper_mode:bind({"ctrl", "alt", "shift", 'command'}, 'h', function() hs.alert.show('Hyper hello world!', {}, 0.5) end)

