plymouth
===========

(C) John Mair (banisterfiend) 2012

_Start Pry in the context of a failed test_

**Warning BETA software: Please file an [issue](https://github.com/banister/plymouth/issues) if you have any problems**

`plymouth` is a gem to automatically start a [Pry](http://pry.github.com) session when a test fails, putting you in the context of the failure.
It currently supports [Bacon](https://github.com/chneukirchen/bacon), [Minitest](https://github.com/seattlerb/minitest), and [RSpec](https://github.com/rspec/rspec). 
Support for other testing libraries is (usually) trivial to add.  

plymouth utilizes the powerful [pry-exception_explorer](https://github.com/pry/pry-exception_explorer) gem.

plymouth currently only runs on **MRI 1.9.2+ (including 1.9.3)**
 
**How to use:**

After installing the [gem](https://rubygems.org/gems/plymouth), simply add the following line to your test suite:

`require 'plymouth'` 

plymouth should auto-detect which testing library you're using, and 'just work' :)


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
Test failure: expected: true
     got: false (using ==)

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
[2] (pry) #<RSpec::Core::ExampleGroup::Nested_1>: 0> edit --current
=> nil
[3] (pry) #<RSpec::Core::ExampleGroup::Nested_1>: 0> ^D
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

Edit the failing test code in an editor
---

Notice the line `edit --current` from the example above. Entering this command will take you to the line in the test file
where the failing test was defined. Once here you can modify the test code as you please. Note that the file will not be
reloaded after editing is complete, instead any modifications you make will only take effect the next time you run the test suite.

Turning plymouth off mid-test
---

If you are inside an interactive session and do not want plymouth to intercept further failing tests you
can enter the command `plymouth-off`. This will disable plymouth for the remainder of the test suite. 

The 'USE_PLYMOUTH' Environment variable
-------

To make it easier to run your test suite normally (without plymouth's intervention) a `USE_PLYMOUTH` environment variable
can be defined. If the `USE_PLYMOUTH` environment variable is set to `"false"`, `"0"`, or `"no"` plymouth will not intercept test failures.
If `USE_PLYMOUTH` is not defined at all, plymouth will be used by default.

Travis Compatibility
---

To prevent plymouth messing up testing on [travis](http://travis-ci.org/), add the following line to your `.travis.yml` file: 

```
env: USE_PLYMOUTH="no"
```

Limitations
-------------------------

* Occasional (very rare) segfault on 1.9.3 (seems to work fine on 1.9.2). Please [report](https://github.com/banister/plymouth/issues) all segfaults with a full backtrace!
* Only supports MRI.
* Currently limited to just Bacon, RSpec and Minitest. Support for more testing libraries will be added in the future.
* Only intercepts test **failures**, does not yet (generally) intercept test **errors**. Support for this will be added soon.
* Does not work with Bacon's `should.raise` and `should.not.raise` constructions.

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
