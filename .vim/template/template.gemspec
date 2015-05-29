# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require ''

Gem::Specification.new do |spec|
  spec.name          = ''
  spec.version       =
  spec.authors       = ['knakayama']
  spec.email         = ['knakayama@gmail.com']
  spec.description   = %q{}
  spec.summary       = %q{}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*', 'spec/**/*', 'bin/*', 'completion/*']
  spec.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = s.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.post_install_message = %q{}

  spec.required_rubygems_version = ''

  spec.add_dependency ''

  spec.add_development_dependency ''
end
