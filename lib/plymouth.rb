# plymouth.rb
# (C) 2012 John Mair (banisterfiend); MIT license

require 'pry'
require 'pry-exception_explorer'
require "plymouth/version"
require 'plymouth/commands'

module Plymouth

  # Enable plymouth.
  # @return [Boolean]
  def self.enable!
    ::EE.enabled = true
  end

  # Disable plymouth.
  # @return [Boolean]
  def self.disable!
    ::EE.enabled = false
  end

  # @return [Boolean] Whether Plymouth is enabled.
  def self.enabled?
    ::EE.enabled?
  end
end

message = nil

# Ensure auto-reloading is off, so that `edit --current` does not try
# to reload the test file
Pry.config.disable_auto_reload = true

# Decorate `whereami` command to include test failure information
Pry.config.commands.before_command("whereami") do
  output.puts
  output.puts "#{Pry::Helpers::Text.bold("Test failure:")} #{message}"
end

if defined?(Bacon)

  EE.intercept do |frame, ex|

    if ex.is_a?(Bacon::Error) && frame.method_name != :run_requirement
      message = ex.message
      true
    else
      false
    end

  end.skip_until { |frame| frame.klass == Bacon::Context }

elsif defined?(RSpec)

  EE.intercept do |frame, ex|

    if ex.class.name =~ /RSpec::Expectations::ExpectationNotMetError/
      message = ex.message
      true
    else
      false
    end

  end.skip_until do |frame|
    frame.klass.name =~ /RSpec::Core::ExampleGroup::Nested/
  end

elsif defined?(MiniTest)

  EE.intercept do |frame, ex|

    if ex.is_a?(MiniTest::Assertion)
      message = ex.message
      true
    else
      false
    end

  end.skip_until do |frame|
    frame.method_name =~ /^test_/
  end
end

# Disable Plymouth if USE_PLYMOUTH environment variable is falsy
Plymouth.enable!
if ['0', 'false', 'no'].include?(ENV['USE_PLYMOUTH'].to_s.downcase)
  Plymouth.disable!
end

# Bring in plymouth commands
Pry.commands.import Plymouth::Commands
