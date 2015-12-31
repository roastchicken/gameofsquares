local block = {}

block.type =
{
  ["stone"] =
  {
    name = "Stone",
    color = game.color.new( 204, 204, 204 ),
    image = nil
  },
  ["log"] =
  {
    name = "Log",
    color = game.color.new( 114, 95, 6 ),
    image = nil
  },
  ["planks"] =
  {
    name = "Wooden Planks",
    color = game.color.new( 180, 150, 10 ),
    image = nil
  }
}

block.order = { "stone", "log", "planks" }

return block