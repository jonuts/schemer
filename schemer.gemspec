
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "schemer/version"

Gem::Specification.new do |spec|
  spec.name          = "schemer"
  spec.version       = Schemer::VERSION
  spec.authors       = ["jonah honeyman"]
  spec.email         = ["jonah@honeyman.org"]

  spec.summary       = %q{Build and validate JSON schemas with a delightful ruby API}
  spec.homepage      = "https://github.com/jonuts/schemer"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.11.3"
  spec.add_development_dependency "guard-rspec", "~> 4.7.3"
end
