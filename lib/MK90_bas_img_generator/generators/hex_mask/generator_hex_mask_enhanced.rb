# frozen_string_literal: true

require "run_length_encoding"

require_relative "hex_mask_enhanced_script"

require_relative "./../../constants"
require_relative "generator_hex_mask_general"
require_relative "./../../BASIC_command_sets/basic_v10_command_set"
require_relative "hex_img"
require_relative "./../../script"

require "delegate"

#
# To save space at the MPO-10 cart, it's possible to replace long sequences of repeating chunks with a shorter
# (in terms of number of chars required to store this statement) code, e.g.:
# xxDRAWMFFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFF  // 43 bytes -- 16 repeating chunks of 'AA'.
# xxDRAWMFF:FORI=1TO16:DRAWMAA:NEXTI:DRAWMFF   // 42 bytes -- repeating chunks were replaced with a loop.
#
# Same principle could be applied to eliminate long sequences of white pixels, e.g.:
# xxDRAWMFF00000000000000000000FF  // 31 bytes -- 10 repeating chunks of '00'.
# xxDRAWMFF:DRAWO100,21:DRAWMFF    // 29 bytes -- replaced with a manual shift.
#
# To do so, it's required to:
# 1. apply RLE to the array of hex chunks (DRAW/M arguments);
# 2. loop through array of run-lengths and search for an instance of the long sequence of repeating chunks;
# 3. if such instance is found: add prepending chunks to the BASIC code; then append a FOR-NEXT loop or DRAW/O;
# 4. otherwise: add current chunk to the array of prepending chunks.
#
class GenHexMaskEnhanced < SimpleDelegator
  #
  # BASIC script generation using DRAW/M feature with 'enhancements'.
  #
  # @param [BinMagick] binary_image
  #
  # @param [Symbol] target_lang
  #
  # @return [HexMaskEnhancedScript] hex_mask_script
  #
  def generate(binary_image:, **kwargs)
    hex_img = _hex_img_from_bin_pixels(binary_image)

    x = kwargs[:origin][:x]
    y = kwargs[:origin][:y]

    hex_mask_script = HexMaskEnhancedScript.new(self)

    hex_mask_script.init(
      hex_img: hex_img,
      rle_hex_img: _encode_hex_img(hex_img.img),
      x: x,
      y: y
    )

    hex_mask_script.compress

    self
  end

  private

  def _hex_img_from_bin_pixels(binary_image)
    hex_img = HexMaskGenerator.generate_hex_mask(binary_image)

    HexImg.new(
      img: hex_img,
      width: binary_image.width,
      height: binary_image.height
    )
  end

  def _encode_hex_img(hex_img)
    rle = RunLengthEncoding.new
    rle.encode(hex_img)
  end
end
