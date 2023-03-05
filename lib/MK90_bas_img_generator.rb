# frozen_string_literal: true

require_relative "MK90_bas_img_generator/generators/hex_mask/generator_hex_mask_default"
require_relative "MK90_bas_img_generator/generators/hex_mask/generator_hex_mask_enhanced"

require_relative "MK90_bas_img_generator/script"

require_relative "MK90_bas_img_generator/constants"
require_relative "MK90_bas_img_generator/version"

#
# Converts a binary image to a list of unformatted MK90 BASIC statements (operator's keywords and arguments).
#
class MK90BasImgGenerator
  attr_reader :generator, :binary_image, :target_lang, :origin, :scan_direction

  include Constants

  def initialize(
    generator:,
    binary_image:,
    target_lang: Basic10CommandSet,
    origin: { x: DEF_X_ORIG, y: DEF_Y_ORIG },
    scan_direction: "placeholder",
    prepend_opt: {},
    append_opt: {}
  )
    @generator = generator
    @binary_image = binary_image
    @origin = origin
    @scan_direction = scan_direction
    @prepend_opt = prepend_opt
    @append_opt = append_opt

    @script = Script.new(target_lang: target_lang)
  end

  #
  # Generate BASIC script with a provided generator & options.
  #
  def generate
    @script.append_opt_statements(@prepend_opt)

    @script = @generator.new(@script)

    _generate_image_script

    @script.append_opt_statements(@append_opt)

    @script.script
  end

  private

  # Generate image.
  def _generate_image_script
    @script.generate(
      binary_image: @binary_image,
      scan_direction: @scan_direction,
      origin: @origin
    )
  end
end
