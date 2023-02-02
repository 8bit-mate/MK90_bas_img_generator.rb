# frozen_string_literal: true

require_relative "basic_shared_command_set"
require_relative "basic_v10_spec_commands"
require_relative "basic_shared_subroutines"

#
# Set of commands and subroutines for the MK90 BASIC v1.0.
#
# MK90 BASIC exists in two main versions: v1.0 & v2.0. Generally these versions have the same syntax and share the same
# set of commands, but BASIC v2.0 also has additional features that were not present in the initial version of the
# language.
#
# Therefore, BASIC v2.0 has backward compatibility with BASIC v1.0, but BASIC v1.0 lacks forward compatibility with the
# newer version.
#
module Basic10CommandSet
  include BasicSharedCommandSet
  include Basic10SpecCommands
  include BasicSharedSubroutines
end
