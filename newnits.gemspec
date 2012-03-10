# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "newnits/version"

Gem::Specification.new do |s|
  s.name        = "newnits"
  s.version     = Newnits::VERSION
  s.authors     = ["David Blackmon"]
  s.email       = ["davidkblackmon@gmail.com"]
  s.homepage    = "https://github.com/davidbl/newnits"
  s.summary     = %q{Numerical units generator and convertor}
  s.description = %q{Allows for units creation and conversions}

  s.rubyforge_project = "newnits"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
end
