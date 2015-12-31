local block = {}

local stone =
{
  name = "Stone",
  color = game.color.new( 204, 204, 204 ),
  image = nil
}

local wood =
{
  name = "Log",
  color = game.color.new( 114, 95, 6 ),
  image = nil
}

local wooden_planks = 
{
  name = "Wooden Planks",
  color = game.color.new( 180, 150, 10 ),
  image = nil
}

block.type = { stone, wood, wooden_planks }

return block