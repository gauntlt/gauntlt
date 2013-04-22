# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gauntlt/version"

Gem::Specification.new do |s|
  s.name        = "gauntlt"
  s.version     = Gauntlt::VERSION
  s.authors     = ["James Wickett", "Mani Tadayon"]
  s.email       = ["james@gauntlt.org"]
  s.homepage    = "https://github.com/gauntlt/gauntlt"
  s.summary     = %q{behaviour-driven security using cucumber}
  s.description = %q{Using standard Gherkin language to define security tests, gauntlt happily wraps cucumber functionality and provides a security testing framework that security engineers, developers and operations teams can collaborate on together.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "cucumber", "1.2.1"
  s.add_development_dependency "aruba"
  s.add_development_dependency "rake"
  s.add_development_dependency "sinatra"

  s.add_runtime_dependency "cucumber"
  s.add_runtime_dependency "aruba"
  s.add_runtime_dependency "nokogiri"
  s.add_runtime_dependency "trollop"
end
