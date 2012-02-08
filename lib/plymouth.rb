# plymouth.rb
# (C) 2012 John Mair (banisterfiend); MIT license

require "plymouth/version"
require 'pry-exception_explorer'

EE.enabled = true

if defined?(Bacon)

  EE.intercept do |frame, ex|
    ex.is_a?(Bacon::Error) && frame.method_name != :run_requirement
  end.skip_until { |frame| frame.klass == Bacon::Context }

elsif defined?(RSpec)

  EE.intercept do |frame, ex|
    ex.class.name =~ /RSpec::Expectations::ExpectationNotMetError/
  end.skip_until do |frame|
    frame.klass.name =~ /RSpec::Core::ExampleGroup::Nested/
  end

elsif defined?(MiniTest)

  EE.intercept(MiniTest::Assertion).skip_until do |frame|
    frame.method_name =~ /^test_/
  end

# elsif defined?(Riot)
#   EE.enabled = false
#   class Riot::Assertion
#     private
#     alias_method :oh_my_old_assert, :assert
#     def assert(*args, &block)
#       result = oh_my_old_assert(*args, &block)
#       if result.first == :fail || result.first == :error
#         Pry.start binding, :call_stack => binding.callers
#       end

#       result
#     end
#   end
end

