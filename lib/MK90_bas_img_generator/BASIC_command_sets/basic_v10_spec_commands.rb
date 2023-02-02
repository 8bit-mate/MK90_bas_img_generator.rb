# frozen_string_literal: true

#
# Set of commands specific for the MK90 BASIC v1.0.
#
module Basic10SpecCommands
  # MK90 BASIC v1.0 command to assing value to a variable.
  def append_let(args:, separator: "", require_nl: false, sliceable: false)
    let_com = {
      keyword: "LET",
      args: args,
      separator: separator,
      require_nl: require_nl,
      sliceable: sliceable
    }
    @script.append(let_com)
  end
end
