local color = {}

function color.new( red, green, blue )
  return { r = red, g = green, b = blue }
end

color.curColor = color.new( 0, 0, 0 )

color.blocks = {}

color.blocks.colors =
{
  black = color.new( 0, 0, 0 ),
  red = color.new( 212, 144, 144 ),
  orange = color.new( 212, 161, 144 ),
  yellow = color.new( 212, 212, 144 ),
  green = color.new( 161, 212, 144 ),
  blue = color.new( 144, 195, 212 ),
  purple = color.new( 195, 144, 212 )
}

color.blocks.order = { "black", "red", "orange", "yellow", "green", "blue", "purple", "none", "none", "none" }

return color