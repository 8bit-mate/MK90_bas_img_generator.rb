# frozen_string_literal: true

require_relative "BASIC_command_sets/basic_v10_command_set"
require_relative "constants"

#
# Stores list of statements (BASIC script tokens) and provides methods to add statements to the script.
#
class Script
  attr_writer :target_lang
  attr_reader :script

  METHOD_PREFIX = "append_"

  def initialize(target_lang: Basic10CommandSet, **)
    @target_lang = target_lang
    extend(target_lang)

    @script = []
  end

  #
  # Append optional statements to the script. Used to append additional statements like clean the screen before building
  # the image, or add a wait loop at the end of a program.
  #
  # @param [Hash { String => Hash }] options
  #   @target_lang method name and options.
  #
  #   Examples:
  #
  #   { "append_cls" => {} }
  #     =>
  #        { :keyword=>"CLS", :args=>[], :separator=>"", :require_nl=>false, :sliceable=>false }
  #
  #   { "append_wait_loop" => { loop_counter: 9, time: 1234 } }
  #     =>
  #        { :keyword=>"FOR", :args=>["I", "=", "1", "TO", "9"], :separator=>"", :require_nl=>true, :sliceable=>false },
  #        { :keyword=>"WAIT", :args=>[1234], :separator=>"", :require_nl=>false, :sliceable=>false },
  #        { :keyword=>"NEXT", :args=>["I"], :separator=>"", :require_nl=>false, :sliceable=>false }
  #
  def append_opt_statements(options)
    return unless options

    options.each do |method, args|
      send(method, **args) if method.start_with?(METHOD_PREFIX) && respond_to?(method)
    end
  end
end
