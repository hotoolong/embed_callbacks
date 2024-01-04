require_relative 'lib/embed_callbacks/version'

Gem::Specification.new do |spec|
  spec.name          = "embed_callbacks"
  spec.version       = EmbedCallbacks::VERSION
  spec.authors       = ["hotoolong"]
  spec.email         = ["hotoolong.hogehoge+github@gmail.com"]

  spec.summary       = %q{Create a method callback.}
  spec.description   = %q{Whenever you want to add a callback, you can easily incorporate the process.\n }
  spec.homepage      = "https://github.com/hotoolong/embed_callbacks"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'codecov', '>= 0.2.0'
end
