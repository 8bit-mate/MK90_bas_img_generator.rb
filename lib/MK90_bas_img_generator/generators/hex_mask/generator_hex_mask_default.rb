# frozen_string_literal: true

require_relative "generator_hex_mask_general"
require_relative "./../../script"

require "delegate"

#
# BASIC script generation using DRAW/M feature without 'enhancements'.
#
# @param [BinMagick] binary_image
#
# @return [Script] script
#
class GenHexMaskDefault < SimpleDelegator
  def generate(binary_image:, **)
    hex_img = HexMaskGenerator.generate_hex_mask(binary_image)

    append_draw_m(args: hex_img)

    self
  end
end
