# frozen_string_literal: true

require_relative "basic_shared_command_set"

#
# Set of subroutines shared both by MK90 BASIC v1.0 & BASIC v2.0.
#
module BasicSharedSubroutines
  # MK90 BASIC loop to pause a program.
  def append_wait_loop(loop_counter: 0, time: 0)
    @script.append_for_loop(args: ["I", "=", "1", "TO", loop_counter.to_s], require_nl: true)
    @script.append_wait(args: [time])
    @script.append_next(args: ["I"])
  end
end
