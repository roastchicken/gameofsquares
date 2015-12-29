game = {}

debugGraph = require( "debugGraph" )
Camera = require( "hump.camera" )

game.color = require( "color" )
local color = game.color
local Color = color.new

require( "input" )

local bgColor = { r = 14, g = 156, b = 14 }
local winX = 1280
local winY = 720

local stepSize = 3
local blockSize = 25

local blocks = {}
game.moving = { up, down, left, right, sprinting }
local moving = game.moving

local xCoord = 0
local yCoord = 0

local function tableRandom( initTbl )
  local randTbl = {}
  for k, v in pairs( initTbl ) do
    table.insert( randTbl, v )
  end
  return randTbl[ math.random( #randTbl ) ]
end

local function findBlock( xCoord, yCoord )
  if blocks[xCoord] then
    if blocks[xCoord][yCoord] then
      return blocks[xCoord][yCoord]
    end
  end
  return false
end

function game.createBlock( xCoord, yCoord, color )
  local block = {}
  xCoord = math.floor( xCoord + 0.5 )
  yCoord = math.floor( yCoord + 0.5 )
  block.color = color or { r = 0, g = 0, b = 0 }
  if not blocks[xCoord] then
    blocks[xCoord] = {}
  end
  blocks[xCoord][yCoord] = block
end

function game.removeBlock( xCoord, yCoord )
  xCoord = math.floor( xCoord + 0.5 )
  yCoord = math.floor( yCoord + 0.5 )
  if blocks[xCoord] then
    if blocks[xCoord][yCoord] then
      blocks[xCoord][yCoord] = nil
    end
  end
end

local function drawBlock( blockXCoord, blockYCoord, color, mode )
    local xPos = ( blockXCoord * blockSize ) - math.floor( blockSize / 2 )
    local yPos = ( blockYCoord * blockSize ) - math.floor( blockSize / 2 )
    love.graphics.setColor( color.r, color.g, color.b )
    love.graphics.rectangle( mode, xPos, yPos, blockSize, blockSize )
end

local function randomGen( size )
  local genColors = color.blocks.colors
  genColors.black = nil
  size = size - 1
  for x = 0 - ( size / 2 ), size / 2 do
    blocks[x] = {}
    for y = 0 - ( size / 2 ), size / 2 do
      local block = {}
      block.color = tableRandom( genColors )
      blocks[x][y] = block
    end
  end
end

function love.load()
  love.window.setMode( winX, winY )
  love.window.setPosition( 0, 0 )
  love.window.setTitle( "Cube Test" )
  
  love.graphics.setBackgroundColor( bgColor.r, bgColor.g, bgColor.b )
  
  camera = Camera( 0, 0 )
  
  game.createBlock( 0, 0 )
  
  fpsGraph = debugGraph:new('fps', 0, 0, 50, 50, 0.5, "FPS", love.graphics.newFont(12) )
end

function love.update( dt )
  local distance = stepSize * dt
  if moving.sprinting then distance = stepSize * 2 * dt end
  
  if moving.up and moving.down then
    
  elseif moving.up then
    yCoord = yCoord - distance
  elseif moving.down then
    yCoord = yCoord + distance
  end
  
  if moving.right and moving.left then
  
  elseif moving.right then
    xCoord = xCoord + distance
  elseif moving.left then
    xCoord = xCoord - distance
  end
  
  camera:lookAt( xCoord * blockSize, yCoord * blockSize )
  
  game.mouseXCoord, game.mouseYCoord = camera:mousePosition()
  
  game.mouseXCoord = game.mouseXCoord / blockSize
  game.mouseYCoord = game.mouseYCoord / blockSize
  
  fpsGraph:update(dt)
end

function love.draw()
  
  camera:attach()
  for xCoord, row in pairs( blocks ) do
    for yCoord, block in pairs( row ) do
      drawBlock( xCoord, yCoord, block.color, "fill" )
    end
  end
  
  drawBlock( math.floor( game.mouseXCoord + 0.5 ), math.floor( game.mouseYCoord + 0.5 ), { r = 55, g = 255, b = 255 }, "line" )
  
  love.graphics.setColor( 0, 70, 255 )
  love.graphics.circle( "fill", xCoord * blockSize, yCoord * blockSize, 50, 48 )
  camera:detach()
  
  love.graphics.setColor( 255, 255, 255 )
  love.graphics.print( xCoord .. ", " .. yCoord , 10, 50 )
  love.graphics.print( game.mouseXCoord .. ", " .. game.mouseYCoord , 10, 60 )
  
  fpsGraph:draw()
end