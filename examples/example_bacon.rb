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

  it 'should have 3 items' do
    [1, 2, 3].size.should == 3
  end

  it 'should contain only numbers' do
     [1, "2", 3].all? { |v| v.is_a?(Fixnum).should == true }
  end
end
