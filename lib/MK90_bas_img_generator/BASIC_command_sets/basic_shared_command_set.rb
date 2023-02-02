# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength

#
# Set of commands shared by both BASIC v1.0 & BASIC v2.0.
#
module BasicSharedCommandSet
  # MK90 BASIC command to clear MK90's screen.
  def append_cls(args: [], separator: "", require_nl: false, sliceable: false)
    cls_com = {
      keyword: "CLS",
      args: args,
      separator: separator,
      require_nl: require_nl,
      sliceable: sliceable
    }
    @script.append(cls_com)
  end

  # MK90 BASIC command to store series of constants.
  def append_data(args:, separator: ",", require_nl: true, sliceable: true)
    data_com = {
      keyword: "DATA",
      args: args,
      separator: separator,
      require_nl: require_nl,
      sliceable: sliceable
    }
    @script.append(data_com)
  end

  # MK90 BASIC command to draw a line by two pairs of coordinates (x0, y0), (x1, y1).
  def append_draw_d(args:, separator: ",", require_nl: false, sliceable: false)
    line_com = {
      keyword: "DRAWD",
      args: args,
      separator: separator,
      require_nl: require_nl,
      sliceable: sliceable
    }
    @script.append(line_com)
  end

  # MK90 BASIC command to draw a pixel by a pair of coordinates (x, y).
  def append_draw_h(args:, separator: ",", require_nl: false, sliceable: false)
    pixel_com = {
      keyword: "DRAWH",
      args: args,
      separator: separator,
      require_nl: require_nl,
      sliceable: sliceable
    }
    @script.append(pixel_com)
  end

  # MK90 BASIC command to draw pixels with hex-encoded 8x1 chunks.
  def append_draw_m(args:, separator: "", require_nl: false, sliceable: true)
    draw_m_com = {
      keyword: "DRAWM",
      args: args,
      separator: separator,
      require_nl: require_nl,
      sliceable: sliceable
    }
    @script.append(draw_m_com)
  end

  # MK90 BASIC command to set the current point to the (x, y).
  def append_draw_o(args:, separator: ",", require_nl: false, sliceable: false)
    draw_o_com = {
      keyword: "DRAWO",
      args: args,
      separator: separator,
      require_nl: require_nl,
      sliceable: sliceable
    }
    @script.append(draw_o_com)
  end

  # MK90 BASIC command to create a FOR loop.
  def append_for_loop(args:, separator: "", require_nl: false, sliceable: false)
    for_loop_com = {
      keyword: "FOR",
      args: args,
      separator: separator,
      require_nl: require_nl,
      sliceable: sliceable
    }
    @script.append(for_loop_com)
  end

  # MK90 BASIC command to mark the end of a FOR loop.
  def append_next(args:, separator: "", require_nl: false, sliceable: false)
    next_com = {
      keyword: "NEXT",
      args: args,
      separator: separator,
      require_nl: require_nl,
      sliceable: sliceable
    }
    @script.append(next_com)
  end

  # MK90 BASIC command to read values from the DATA.
  def append_read(args:, separator: ",", require_nl: false, sliceable: false)
    read_com = {
      keyword: "READ",
      args: args,
      separator: separator,
      require_nl: require_nl,
      sliceable: sliceable
    }
    @script.append(read_com)
  end

  # MK90 BASIC command to pause a program.
  def append_wait(args:, separator: "", require_nl: false, sliceable: false)
    wait_com = {
      keyword: "WAIT",
      args: args,
      separator: separator,
      require_nl: require_nl,
      sliceable: sliceable
    }
    @script.append(wait_com)
  end
end

# rubocop:enable Metrics/ModuleLength
