# -*- encoding: utf-8 -*-

require File.dirname(__FILE__) + "/lib/unicopy/version"

Gem::Specification.new do |gem|
  gem.name          = "unicopy"
  gem.version       = Unicopy::VERSION
  gem.summary       = "Converts Unicode codepoints to a string (or vice versa) and copies it to the system clipboard"
  gem.description   = "Converts Unicode codepoints to a string (or vice versa) and copies it to the system clipboard. Can also convert codepoints to many dump formats."
  gem.authors       = ["Jan Lelis"]
  gem.email         = ["hi@ruby.consulting"]
  gem.homepage      = "https://github.com/janlelis/unicopy"
  gem.license       = "MIT"

  gem.files         = Dir["{**/}{.*,*}"].select{ |path| File.file?(path) && path !~ /^(pkg|screenshots)/ }
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.metadata      = { "rubygems_mfa_required" => "true" }

  gem.add_dependency 'paint', '>= 0.9', '< 3.0'
  gem.add_dependency 'rationalist', '~> 2.0'
  gem.add_dependency 'clipboard', '~> 1.1'

  gem.required_ruby_version = ">= 2.0"
end
