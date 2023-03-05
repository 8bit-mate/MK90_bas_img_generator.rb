require_relative "./../../script"

class HexMaskEnhancedScript < Script
  attr_writer :hex_img, :rle_hex_img, :x, :y
  attr_reader :script

  MIN_REP_CHUNKS = 16
  MIN_REP_WH_CHUNKS = 10

  CHUNK_WIDTH = 8

  #
  # @param [HexImg] hex_img
  #   A binary image represented in a form of 8x1 hex-encoded chunks.
  #
  # @param [Array<Hash{ Symbol => Object }>] rle_hex_img
  #   The same hex-encoded chunks packed with RLE.
  #
  # @param [Integer] x
  # @param [Integer] y
  #   Image origin point on the screen.
  #
  def initialize(
    hex_img:,
    rle_hex_img:,
    x: 0,
    y: 0,
    **
  )
    @hex_img = hex_img
    @rle_hex_img = rle_hex_img
    @x = x
    @y = y

    super
  end

  def compress
    @prepending_chunks = []
    @run_length_index = 0

    @rle_hex_img.each_with_index do |rle_el, i|
      @chunk_count = rle_el[:count]
      @chunk = rle_el[:chunk]

      _calc_current_pos

      if @chunk_count >= MIN_REP_WH_CHUNKS && @chunk == "00"
        _process_white_segments(i)
        next
      elsif @chunk_count >= MIN_REP_CHUNKS && @chunk != "00"
        _process_non_white_segments
        next
      end

      _upd_prepending_chunks
      _upd_rle_index
    end

    _add_prepending_chunks
  end

  private

  # Calculate current (X, Y) position.
  def _calc_current_pos
    @y += @chunk_count
    return unless @y > @hex_img.height - 1

    # reached the vertical end of the image - re-calculate position:
    div_res = @y.div(@hex_img.height)
    rem = @y.remainder(@hex_img.height)
    @x += CHUNK_WIDTH * div_res
    @y = rem
  end

  def _upd_rle_index
    @run_length_index += @chunk_count
  end

  def _clr_prepending_chunks
    @prepending_chunks = []
  end

  # Replace long sequences of repeating chunks with a shorter FOR-NEXT loop.
  def _process_non_white_segments
    _add_prepending_chunks
    _clr_prepending_chunks

    append_for_loop(args: ["I", "=", "1", "TO", @chunk_count.to_s])
    append_draw_m(args: [@chunk])
    append_next(args: ["I"])

    _upd_rle_index
  end

  # Replace long sequences of white chunks (0x00) with a shorter manual shift of the (X, Y) pointer.
  def _process_white_segments(idx)
    # if white segments are the last part of the image,
    # we don't need to store them in the BASIC script at all
    return if idx == @rle_hex_img.length - 1

    _add_prepending_chunks
    _clr_prepending_chunks

    coordinates = [@x, @y]
    append_draw_o(args: coordinates)

    _upd_rle_index
  end

  def _add_prepending_chunks
    return if @prepending_chunks == []

    append_draw_m(args: @prepending_chunks)
  end

  def _upd_prepending_chunks
    # get chunks that are prepending at the current itteration:
    current_chunks = @hex_img.img.slice(@run_length_index, @chunk_count)

    @prepending_chunks.concat current_chunks
  end
end
