# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "alacrity_client/version"

Gem::Specification.new do |s|
  s.name        = "alacrity_client"
  s.version     = AlacrityClient::VERSION
  s.authors     = ["Sean Reilly"]
  s.email       = ["sean@otoanalytics.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "alacrity_client"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_development_dependency "rspec", "~> 2.6"	
  s.add_dependency "em-http-request", "~> 1.0.0"   
end
