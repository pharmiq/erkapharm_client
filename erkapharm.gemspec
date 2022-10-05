Gem::Specification.new do |spec|
  spec.name = 'erkapharm'
  spec.version = '1.0.0'
  spec.authors = ['Sergey Zabolotnov']
  spec.email = ['sergey@pharmiq.ru']
  spec.summary = 'The client for the Erkapharm API'
  spec.required_ruby_version = '~> 3.0'
  spec.files = Dir['app/**/*', 'lib/**/*', 'config/**/*', 'README.md']
  spec.require_paths = ['lib']
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.add_dependency 'faraday', '~> 2.0'
  spec.add_dependency 'hashie', '>= 3.4', '< 5.0'
  spec.add_dependency 'rack', '>= 1.5', '< 3.0'
end
