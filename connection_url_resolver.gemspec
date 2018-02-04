
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "connection_url_resolver/version"

Gem::Specification.new do |spec|
  spec.name          = "connection_url_resolver"
  spec.version       = ConnectionUrlResolver::VERSION
  spec.authors       = ["Juanito Fatas"]
  spec.email         = ["katehuang0320@gmail.com"]

  spec.summary       = %(Resolve connection URL into Hash.)
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/JuanitoFatas/connection_url_resolver"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
