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
require 'newnits_extended' # includes the module into Numeric
1.feet.to :inches
 => <Newnits::Base#70242672341580, @value=12/1, @unit=#<Newnits::Unit:0x007fc54b10e560>:inch, @to_f=12.0>
1.foot.to(:inches).to_f
 => 12.0
1.foot.squared.to(:inches, 2).to_f
 => 144.0
2.feet.to(:inches).to_f
 => 24.0 
```

or, if you don't want to 'pollute' Numeric

```ruby
require 'newnits' # includes the module into Numeric
newnit = Newnits::Base.new(2, :feet)
 => <Newnits::Base#70172326712340, @value=2/1, @unit=#<Newnits::Unit:0x007fa489365c38>:feet, @to_f=2.0>
inches =  newnit.to(:inches)
 => Newnits::Base#70172326683220, @value=24/1, @unit=#<Newnits::Unit:0x007fa48935c570>:inch, @to_f=24.0> 
inches.to_f
 => 24.0
```

You can use exponents
---------------------

```ruby
area = 1.acre.to(:feet, 2).to_f
 => 43560.0 

43_560.feet.to_the(2).to(:acres).to_f
 => 1.0

43_560.feet_squared.to(:acres).to_f
 => 1.0
```

You can also create more complex units
--------------------------------------

```ruby
speed = 180.feet.per(:minute).to(:yards, :per, :second)
=> <Newnits::Base#70172326633280, @value=1/1, @unit=#<Newnits::Unit:0x007fa489345d98>:yard, @to_f=1.0> 
speed.to_f
=> 1.0
```

And you can create your own units
--------------------------------------

```ruby
Newnits::Units.add :furlong, Rational('201.168'), :length
8.furlongs.to(:miles).to_f
 => 1.0
```






