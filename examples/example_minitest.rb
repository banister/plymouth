unless Object.const_defined? :Plymouth
  $:.unshift File.expand_path '../../lib', __FILE__
end

require 'minitest/autorun'
require 'minitest/spec'
require 'plymouth'

describe Array do
  before do
    @array = [1]
  end

  it 'should be empty' do
    @array.empty?.must_equal true
  end
end
