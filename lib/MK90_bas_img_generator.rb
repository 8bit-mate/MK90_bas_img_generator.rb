# frozen_string_literal: true

require_relative "MK90_bas_img_generator/generators/hex_mask/generator_hex_mask_default"
require_relative "MK90_bas_img_generator/generators/hex_mask/generator_hex_mask_enhanced"

require_relative "MK90_bas_img_generator/constants"
require_relative "MK90_bas_img_generator/version"

#
# Convert a binary image to a list of unformatted MK90 BASIC statements (operator's keywords and arguments).
#
class MK90BasImgGenerator
  attr_reader :generator, :binary_image, :target_lang, :origin, :scan_direction

  include Constants

  def initialize(
    generator:,
    binary_image:,
    target_lang: BASIC_10,
    origin: { x: 0, y: 0 },
    scan_direction: "placeholder"
  )
    @generator = generator
    @binary_image = binary_image
    @target_lang = target_lang
    @origin = origin
    @scan_direction = scan_direction
  end

  #
  # Generate BASIC script with a provided generator & options.
  #
  def generate
    script = generator.generate(
      binary_image: @binary_image,
      target_lang: @target_lang,
      scan_direction: @scan_direction,
      origin: @origin
    )

    script.script
  end
end
