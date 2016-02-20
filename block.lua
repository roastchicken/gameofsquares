local block = {}

local blocks = game.blocks

block.type =
{
  ["stone"] =
  {
    name = "Stone",
    id = 1,
    image = { 0, 0 }
  },
  ["log"] =
  {
    name = "Log",
    id = 2,
    image = { 1, 0 }
  },
  ["planks"] =
  {
    name = "Wooden Planks",
    id = 3,
    image = { 0, 1 }
  },
  ["leaves"] =
  {
    name = "Leaves",
    id = 4,
    image = { 1, 1 }
  }
}

function block.find( xCoord, yCoord )
  if blocks[xCoord] then
    if blocks[xCoord][yCoord] then
      return blocks[xCoord][yCoord]
    end
  end
  return false
end

function block.create( xCoord, yCoord, type )
  xCoord = math.floor( xCoord + 0.5 )
  yCoord = math.floor( yCoord + 0.5 )
  if block.find( xCoord, yCoord ) then return end
  if not blocks[xCoord] then
    blocks[xCoord] = {}
  end
  blocks[xCoord][yCoord] = { quad = type.quad }
end

function block.remove( xCoord, yCoord )
  xCoord = math.floor( xCoord + 0.5 )
  yCoord = math.floor( yCoord + 0.5 )
  if blocks[xCoord] then
    if blocks[xCoord][yCoord] then
      blocks[xCoord][yCoord] = nil
    end
  end
end

return block