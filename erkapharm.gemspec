# frozen_string_literal: true

require_relative 'lib/erkapharm/version'

Gem::Specification.new do |spec|
  spec.name = 'erkapharm'
  spec.version = Erkapharm::VERSION
  spec.authors = ['Sergey Zabolotnov']
  spec.email = ['sergey@pharmiq.ru']
  spec.summary = 'The gem-client to the Erkapharm API'
  spec.required_ruby_version = '>= 3.0.0'
  spec.files = Dir['app/**/*', 'lib/**/*', 'config/**/*', 'README.md']
  spec.require_paths = ['lib']
  spec.metadata = {
    'rubygems_mfa_required' => 'true',
  }

  spec.add_dependency 'faraday', '~> 0.9'
  spec.add_dependency 'hashie', '~> 3.4'
  spec.add_dependency 'rack', '>= 1.5', '< 3.0'
end
