local blocks = game.color.blocks

local function selectSlot( slotNum )
  print( "Selected slot #" .. tostring( slotNum ) )
  local loc = slotNum + 1
  local colorName = blocks.order[ loc ]
  if colorName then
    if blocks.colors[ colorName ] then
      game.color.curColor = blocks.colors[ colorName ]
    else
      game.color.curColor = game.color.new( 0, 0, 0 )
    end
  else
    blocks.order[ loc ] = "none"
  end
end

local actions =
{
  quit = function() love.event.quit() end,
  placeBlock = function() game.createBlock( game.mouseXCoord, game.mouseYCoord, game.color.curColor ) end,
  destroyBlock = function() game.removeBlock( game.mouseXCoord, game.mouseYCoord ) end,
  ["+moveUp"] = function() game.moving.up = true end,
  ["-moveUp"] = function() game.moving.up = false end,
  ["+moveDown"] = function() game.moving.down = true end,
  ["-moveDown"] = function() game.moving.down = false end,
  ["+moveLeft"] = function() game.moving.left = true end,
  ["-moveLeft"] = function() game.moving.left = false end,
  ["+moveRight"] = function() game.moving.right = true end,
  ["-moveRight"] = function() game.moving.right = false end,
  ["+moveUp"] = function() game.moving.up = true end,
  ["-moveUp"] = function() game.moving.up = false end,
  ["+sprint"] = function() game.moving.sprinting = true end,
  ["-sprint"] = function() game.moving.sprinting = false end
}

local bindings =
{
  escape = "quit",
  mouse1 = "placeBlock",
  mouse2 = "destroyBlock",
  w = "+moveUp",
  s = "+moveDown",
  a = "+moveLeft",
  d = "+moveRight",
  ["lshift"] = "+sprint"
}

for slotNum = 0, 9 do
  local slot = "slot" .. tostring( slotNum )
  actions[ slot ] = function() selectSlot( slotNum ) end
  bindings[tostring( slotNum )] = slot
end

local function handleInput( actionName )
  local action = actions[ actionName ]
  if action then
    print( actionName .. " is a valid action." )
    action()
  else
    print( actionName .. " is not a valid action." )
    return
  end
end

local function bindPress( key )
  local actionName = bindings[ key ]
  if actionName then
    print( key .. " is bound to " .. actionName )
    handleInput( actionName )
  else
    print( key .. " is not bound to any action. " )
  end
end

local function bindRelease( key )
  local actionName = bindings[ key ]
  if actionName then
    actionName = string.gsub( actionName, "+", "-" )
    print( key .. "(release) is bound to " .. actionName )
    handleInput( actionName )
  else
    print( key .. "(release) is not bound to any action. " )
  end
end

function love.keypressed( key )
  bindPress( key )
end

function love.keyreleased( key )
  bindRelease( key )
end

function love.mousepressed( mouseX, mouseY, button, touch )
  bindPress( "mouse" .. tostring( button ) )
end