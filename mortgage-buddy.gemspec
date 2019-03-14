# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mortgage_buddy/version'

Gem::Specification.new do |spec|
  spec.name        = "mortgage-buddy"
  spec.version     = MortgageBuddy::VERSION
  spec.authors     = ["Perry Hertler"]
  spec.email       = ["perry@hertler.org"]
  spec.homepage    = "https://github.com/perryqh/mortgage-buddy"
  spec.summary     = %q{Some mortgage calculation helpers}
  spec.description = %q{Some mortgage calculation helpers}
  spec.license     = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "pry-nav"
  spec.add_dependency "activesupport"
end
