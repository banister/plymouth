unless Object.const_defined? :Plymouth
  $:.unshift File.expand_path '../../lib', __FILE__
end

require 'plymouth'

describe Array do
  before do
    @array = [1]
  end

  it 'should be empty' do
    @array.empty?.should == true
  end
end
