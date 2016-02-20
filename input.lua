local function selectSlot( slotNum )
  print( "Selected slot #" .. tostring( slotNum ) )
  local item = game.config.hotBar[ slotNum ]
  if item then
    local block = game.block.type[item] or false
    if block then
      game.curBlockType = block
    else
      game.curBlockType = game.block.type.stone
    end
  else
    game.config.hotBar[ slotNum ] = "none"
  end
end

local actions =
{
  quit = function() love.event.quit() end,
  placeBlock = function() game.block.create( game.mouseXCoord, game.mouseYCoord, game.curBlockType ) end,
  destroyBlock = function() game.block.remove( game.mouseXCoord, game.mouseYCoord ) end,
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
  mouse1 = "destroyBlock",
  mouse2 = "placeBlock",
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