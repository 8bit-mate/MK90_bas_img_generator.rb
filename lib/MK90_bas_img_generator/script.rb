# frozen_string_literal: true

require_relative "BASIC_command_sets/basic_v10_command_set"
require_relative "constants"

class Script
  attr_writer :target_lang
  attr_reader :script

  def initialize(target_lang: BASIC_10, **)
    @target_lang = target_lang
    extend(target_lang)

    @script = []
  end

  def prepend_options(prepend_options)
    return unless prepend_options

    prepend_options.each do |method, args|
      send(method, **args)
    end
  end
end
