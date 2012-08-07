# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gauntlt/version"

Gem::Specification.new do |s|
  s.name        = "gauntlt"
  s.version     = Gauntlt::VERSION
  s.authors     = ["James Wickett", "Mani Tadayon"]
  s.email       = ["james@ruggeddevops.org"]
  s.homepage    = "https://github.com/thegauntlet/gauntlt"
  s.summary     = %q{behaviour-driven security using cucumber}
  s.description = %q{Using standard Gherkin language to define security tests, gauntlt happily wraps cucumber functionality and provides a security testing framework that security engineers, developers and operations teams can collaborate on together.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "cucumber"
  s.add_development_dependency "rspec", "~> 2.11"
  s.add_development_dependency "aruba"
  s.add_development_dependency "rake"

  s.add_runtime_dependency "cucumber"
  s.add_runtime_dependency "aruba"
  s.add_runtime_dependency "curb"
  s.add_runtime_dependency "nokogiri"
  s.add_runtime_dependency "trollop"
end
