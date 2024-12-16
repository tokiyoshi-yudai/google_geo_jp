
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "google_geo_jp/version"

Gem::Specification.new do |spec|
  spec.name          = "google_geo_jp"
  spec.version       = GoogleGeoJp::VERSION
  spec.authors       = ["Yudai Tokiyoshi"]
  spec.email         = ["get.on.well0717+gem@gmail.com"]

  spec.summary       = "A simple module for geocoding with Google Maps."
  spec.description   = "Provides google geocoding without the need for coding."
  spec.homepage      = "https://github.com/tokiyoshi-yudai/google_geo_jp"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "activesupport"
end
