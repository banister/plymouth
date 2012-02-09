# plymouth.rb
# (C) 2012 John Mair (banisterfiend); MIT license

require "plymouth/version"
require 'pry-exception_explorer'

if !ENV.has_key?("USE_PLYMOUTH")
  EE.enabled = true
elsif ["0", "false", "no"].include?(ENV["USE_PLYMOUTH"].downcase)
  EE.enabled = false
else
  EE.enabled = true
end


message = nil

# Ensure auto-reloading is off, so that `edit --current` does not try
# to reload the test file
Pry.config.disable_auto_reload

# Decorate `whereami` command to include test failure information
Pry.config.commands.before_command("whereami") do
  output.puts
  output.puts "#{Pry::Helpers::Text.bold("Test failure:")} #{message}"
end

if defined?(Bacon)

  EE.intercept do |frame, ex|

    if ex.is_a?(Bacon::Error) && frame.method_name != :run_requirement
      message = ex
      true
    else
      false
    end

  end.skip_until { |frame| frame.klass == Bacon::Context }

elsif defined?(RSpec)

  EE.intercept do |frame, ex|

    if ex.class.name =~ /RSpec::Expectations::ExpectationNotMetError/
      message = ex
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
      message = ex
      true
    else
      false
    end

  end.skip_until do |frame|
    frame.method_name =~ /^test_/
  end
end


