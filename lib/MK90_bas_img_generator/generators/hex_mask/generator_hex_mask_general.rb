# frozen_string_literal: true

#
# Core methods to generate BASIC script using DRAW/M feature.
#
module HexMaskGenerator
  CHUNK_SIZE = 8

  #
  # Generate script.
  #
  # @param [BinaryImage] binary_image
  #
  # @return [Array<Hash{ Symbol => Object }>] hex_img
  #
  def self.generate_hex_mask(binary_image)
    hex_img = []

    (0...binary_image.width).step(CHUNK_SIZE).each do |x|
      (0...binary_image.height).each do |y|
        chunk = make_chunk(binary_image.pixels, x, y)
        hex_img.push(bin_to_hex(chunk))
      end
    end

    hex_img
  end

  #
  # Form a string of 8 x binary values.
  #
  def self.make_chunk(binary_pixels, x, y)
    chunk = ""
    (0...CHUNK_SIZE).each do |i|
      chunk += binary_pixels[[x + i, y]].to_s
    end
    chunk
  end

  #
  # Convert a string of 8 x binary values to a two-digit hex representation.
  #
  def self.bin_to_hex(str)
    ("%02x" % str.to_i(2)).upcase
  end
end
