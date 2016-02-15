game = {}

local blocksAtlas
local blocksAtlasSize = { x = 0, y = 0 }

debugGraph = require( "debugGraph" )
Camera = require( "hump.camera" )

game.color = require( "color" )
local color = game.color
local Color = color.new

game.config = require( "config" )
local config = game.config
local blockSize = config.constant.blockSize

game.block = require( "block" )

game.curBlockType = game.block.type.stone

require( "input" )

local bgColor = { r = 14, g = 156, b = 14 }

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

local function loadBlocksAtlas()
  blocksAtlas = love.graphics.newImage( "resources/blocks.png" )
  blocksAtlas:setFilter( "nearest", "nearest" )
  blocksAtlasSize.x = blocksAtlas:getWidth() / 16
  blocksAtlasSize.y = blocksAtlas:getHeight() / 16
end

loadBlocksAtlas()

local function loadBlockTypes()
  for key, blockType in pairs( game.block.type ) do
    local image = blockType.image
    game.block.type[key].quad = love.graphics.newQuad( image[1] * blockSize, image[2] * blockSize, blockSize, blockSize, blockSize * blocksAtlasSize.x, blockSize * blocksAtlasSize.u )
  end
end

loadBlockTypes()

local function findBlock( xCoord, yCoord )
  if blocks[xCoord] then
    if blocks[xCoord][yCoord] then
      return blocks[xCoord][yCoord]
    end
  end
  return false
end

function game.createBlock( xCoord, yCoord, type )
  xCoord = math.floor( xCoord + 0.5 )
  yCoord = math.floor( yCoord + 0.5 )
  if findBlock( xCoord, yCoord ) then return end
  if not blocks[xCoord] then
    blocks[xCoord] = {}
  end
  blocks[xCoord][yCoord] = { color = type.color, quad = type.quad }
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

local function drawBlock( blockXCoord, blockYCoord, color, mode, quad )
  local xPos = ( blockXCoord * blockSize ) - math.floor( blockSize / 2 )
  local yPos = ( blockYCoord * blockSize ) - math.floor( blockSize / 2 )
  if quad then
    love.graphics.draw( blocksAtlas, quad, xPos, yPos)
  else
    love.graphics.setColor( color.r, color.g, color.b )
    love.graphics.rectangle( mode, xPos, yPos, blockSize, blockSize )
  end
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
  love.window.setMode( config.window.xSize, config.window.ySize )
  love.window.setTitle( "Game of Squares" )
  
  love.graphics.setBackgroundColor( bgColor.r, bgColor.g, bgColor.b )
  
  camera = Camera( 0, 0 )
  
  fpsGraph = debugGraph:new('fps', 0, 0, 50, 50, 0.5, "FPS", love.graphics.newFont(12) )
end

function love.update( dt )
  local distance = config.constant.stepSize * dt
  if moving.sprinting then distance = config.constant.stepSize * 2 * dt end
  
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
      drawBlock( xCoord, yCoord, block.color, "fill", block.quad )
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