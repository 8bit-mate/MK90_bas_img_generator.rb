class HexImg
  attr_accessor :img, :width, :height

  def initialize(img:, width:, height:, **)
    @img = img
    @width = width
    @height = height
  end
end
