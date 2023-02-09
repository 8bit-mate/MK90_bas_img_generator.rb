# frozen_string_literal: true

require_relative "generator_hex_mask_general"
require_relative "./../../script"

#
# BASIC script generation using DRAW/M feature without 'enhancements'.
#
# @param [BinMagick] binary_image
#
# @param [Symbol] target_lang
#
# @return [Script] script
#
class GenHexMaskDefault
  def generate(binary_image:, target_lang:, **)
    hex_img = HexMaskGenerator.generate_hex_mask(binary_image)

    script = Script.new(target_lang: target_lang)

    script.append_draw_m(args: hex_img)

    script
  end
end
