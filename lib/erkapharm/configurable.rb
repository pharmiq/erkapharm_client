# frozen_string_literal: true

module Erkapharm
  module Configurable
    CONFIGURATION_OPTIONS = %i[
      api_endpoint
      login
      password
      logger
      open_timeout
      read_timeout
    ].freeze

    DEFAULTS_READ_TIMEOUT = 5
    DEFAULTS_OPEN_TIMEOUT = 2

    attr_accessor(*CONFIGURATION_OPTIONS)

    def configure
      yield self
      set_defaults
    end

    def set_defaults
      self.read_timeout ||= DEFAULTS_READ_TIMEOUT
      self.open_timeout ||= DEFAULTS_OPEN_TIMEOUT
      self.logger ||= Logger.new($stderr)
    end

    def options
      CONFIGURATION_OPTIONS.map { |attr| [attr, send(attr)] }.to_h
    end

    def same_options?(options)
      self.options.hash == options.hash
    end
  end
end
