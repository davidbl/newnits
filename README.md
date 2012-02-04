Newnits
=======
A unit conversion library for Ruby

Install
=======
(I haven't published this yet since it is still a work in progress, so
to install, fork the project, cd in to the directory and
```ruby
gem build newnits.gemspec
rake install
```

Yea, well how about some examples?
----------------------------------

```ruby
require 'newnits'
require 'newnits/extenions' # includes the module into Numeric, so we
can do
1.feet.to :inches
 => <Newnits::Base#70242672341580, @value=12/1, @unit=#<Newnits::Unit:0x007fc54b10e560>:inch, @to_f=12.0>
1.feet.to(:inches).to_f
 => 12.0
1.feet.squaures.to(:inches, :squared).to_f
 => 144.0
```



