local block = {}

local Color = game.color.new

block.type =
{
  ["stone"] =
  {
    name = "Stone",
    id = 1,
    color = Color( 204, 204, 204 ),
    image = { 0, 0 }
  },
  ["log"] =
  {
    name = "Log",
    id = 2,
    color = Color( 114, 95, 6 ),
    image = { 1, 0 }
  },
  ["planks"] =
  {
    name = "Wooden Planks",
    id = 3,
    color = Color( 180, 150, 10 ),
    image = { 0, 1 }
  },
  ["leaves"] =
  {
    name = "Leaves",
    id = 4,
    color = Color( 10, 171, 40 ),
    image = { 1, 1 }
  }
}

return block