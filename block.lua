local block = {}

block.type =
{
  ["stone"] =
  {
    name = "Stone",
    id = 1,
    color = game.color.new( 204, 204, 204 ),
    image = nil
  },
  ["log"] =
  {
    name = "Log",
    id = 2,
    color = game.color.new( 114, 95, 6 ),
    image = nil
  },
  ["planks"] =
  {
    name = "Wooden Planks",
    id = 3,
    color = game.color.new( 180, 150, 10 ),
    image = nil
  }
}

return block