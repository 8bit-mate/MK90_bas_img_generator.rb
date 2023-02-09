# frozen_string_literal: true

require "bin_magick"

#
# Core methods to generate BASIC script using DRAW/M feature.
#
module HexMaskGenerator
  CHUNK_WIDTH = 8

  #
  # Generate script.
  #
  # @param [BinMagick] binary_image
  #
  # @return [Array<Hash{ Symbol => Object }>] hex_img
  #
  def self.generate_hex_mask(binary_image)
    hex_img = []

    binary_image = extend_width(binary_image) unless divisible_width?(binary_image)

    (0...binary_image.width).step(CHUNK_WIDTH).each do |x|
      (0...binary_image.height).each do |y|
        chunk = grab_chunk(binary_image, x, y)
        hex_img.push(bin_to_hex(chunk))
      end
    end

    hex_img
  end

  #
  # Check if the image has width that is divisible by 8 (CHUNK_WIDTH) with zero remainder.
  #
  # @return [Boolean]
  #
  def self.divisible_width?(binary_image)
    binary_image.width.remainder(CHUNK_WIDTH).zero?
  end

  #
  # Using DRAW/M operator requires that image width should be divisible by 8 (CHUNK_WIDTH). So if image doesn't comply
  # with this condition, it is required to extend image width to a nearlest number n: n.remainder(CHUNK_WIDTH) == 0.
  #
  # return [BinMagick]
  #   New image with extended width.
  #
  def self.extend_width(binary_image)
    rem = binary_image.width.remainder(CHUNK_WIDTH)
    new_width = binary_image.width + (CHUNK_WIDTH - rem)

    x_offset = 0
    y_offset = 0

    binary_image.extent(new_width, binary_image.height, x_offset, y_offset)
  end

  #
  # Form a string of 8 x binary values.
  #
  # @return [String]
  #
  def self.grab_chunk(binary_image, x, y)
    chunk_width = CHUNK_WIDTH
    chunk_heigth = 1
    pixels = binary_image.get_pixels(x, y, chunk_width, chunk_heigth)

    pixels.map { |pixel| pixel.to_color == "black" ? 1 : 0 }.join("")
  end

  #
  # Convert a string of 8 x binary values to a two-digit hex representation.
  #
  def self.bin_to_hex(str)
    ("%02x" % str.to_i(2)).upcase
  end
end
