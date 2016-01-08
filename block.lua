local block = {}

local Color = game.color.new

block.type =
{
  ["stone"] =
  {
    name = "Stone",
    id = 1,
    color = Color( 204, 204, 204 ),
    image = nil
  },
  ["log"] =
  {
    name = "Log",
    id = 2,
    color = Color( 114, 95, 6 ),
    image = nil
  },
  ["planks"] =
  {
    name = "Wooden Planks",
    id = 3,
    color = Color( 180, 150, 10 ),
    image = nil
  }
}

return block