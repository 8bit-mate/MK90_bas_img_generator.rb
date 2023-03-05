# frozen_string_literal: true

#
# Stores hex-encoded image with its width and height.
#
class HexImg
  attr_accessor :img, :width, :height

  #
  # @return [Array<String>] hex_img
  #   An encoded image, represented as a list of hex-chunks.
  #
  # @param [Integer] width
  #   Image width.
  #
  # @param [Integer] height
  #   Image height.
  #
  def initialize(img:, width:, height:, **)
    @img = img
    @width = width
    @height = height
  end
end
