plymouth
===========

(C) John Mair (banisterfiend) 2012

_Start an interactive session when a test fails_

**Please note, this is a first release  (BETA)for plymouth and as such it may still have teething problems. If you encounter any quirks or crashes please file an [issue](https://github.com/banister/plymouth)**

`plymouth` is a gem to automatically start a [Pry](http://pry.github.com) session when a test fails, putting you in the context of the failure.
It currently supports [Bacon](https://github.com/chneukirchen/bacon), [Minitest](https://github.com/seattlerb/minitest), and [RSpec](https://github.com/rspec/rspec). 
Support for other testing libraries is (usually) trivial to add.

**plymouth currently only supports MRI 1.9.2+ (including 1.9.3)**

* Install the [gem](https://rubygems.org/gems/plymouth): `gem install plymouth`
* See the [source code](http://github.com/banister/plymouth)
 
**How to use:**

Simply add the following line to your test files:

`require 'plymouth'` 

`plymouth` should auto-detect which testing library you're using, and 'just work' :)


Example: Intercept a failing test in RSpec
--------

Inside the test file:

```ruby
require 'plymouth'

describe Array do
  before do
    @array = [1]
  end

  it 'should be empty' do
    @array.empty?.should == true
  end
end
```

And here is the result of running the above test with the `rspec` executable:

```ruby
Frame number: 0/14
Frame type: block

From: /Users/john/ruby/play/rspec_intercept.rb @ line 9:

     4:   before do
     5:     @array = [1]
     6:   end
     7: 
     8:   it 'should be empty' do
 =>  9:     @array.empty?.should == true
    10:   end
    11: end

[1] (pry) #<RSpec::Core::ExampleGroup::Nested_1>: 0> @array.size                                                                                                                           
=> 1
[2] (pry) #<RSpec::Core::ExampleGroup::Nested_1>: 0> ^D
F

Failures:

  1) Array should be empty
     Failure/Error: @array.empty?.should == true
       expected: true
            got: false (using ==)
     # ./rspec_intercept.rb:9:in `block (2 levels) in <top (required)>'

Finished in 7.74 seconds
1 example, 1 failure

Failed examples:

rspec ./rspec_intercept.rb:8 # Array should be empty
```

Limitations
-------------------------

* Occasional segfault on 1.9.3 (seems to work fine on 1.9.2). Please [report](https://github.com/banister/plymouth) all segfaults with a full backtrace!
* Only supports MRI.
* Currently limited to just Bacon, RSpec and Minitest. Support for more testing libraries will be added in the future.

Contact
-------

Problems or questions contact me at [github](http://github.com/banister)


License
-------

(The MIT License) 

Copyright (c) 2012 John Mair (banisterfiend)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
