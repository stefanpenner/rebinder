# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rebinder/version"

Gem::Specification.new do |s|
  s.name        = "rebinder"
  s.version     = Rebinder::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Stefan Penner"]
  s.email       = ["Stefan.Penner@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Rebind a method in ruby}
  s.description = %q{More then likely a terrible idea, but a fun addition, this allows you to rebind a method}

  s.rubyforge_project = "rebinder"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
