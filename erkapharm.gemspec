# frozen_string_literal: true

require_relative "lib/erkapharm/version"

Gem::Specification.new do |spec|
  spec.name = "erkapharm"
  spec.version = Erkapharm::VERSION
  spec.authors = ["Sergey Zabolotnov"]
  spec.email = ["sergey@pharmiq.ru"]
  spec.summary = "The gem-client to the Erkapharm API"
  spec.required_ruby_version = ">= 2.6.0"
  spec.files = Dir['app/**/*', 'lib/**/*', 'config/**/*', 'README.md']
  spec.require_paths = ["lib"]
end
