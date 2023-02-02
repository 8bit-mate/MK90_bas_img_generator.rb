# frozen_string_literal: true

#
# Stores binary image.
#
class BinaryImage
  attr_reader :pixels

  def initialize(pixels)
    @pixels = pixels
  end

  # Return image height.
  def height
    (_width, height) = @pixels.keys.last
    height + 1
  end

  # Return image width.
  def width
    (width, _height) = @pixels.keys.last
    width + 1
  end
end
