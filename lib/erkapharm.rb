# frozen_string_literal: true

require 'faraday'
require 'json'
require 'hashie'
require 'rack/utils'
require 'rack/request'
require 'rack/response'
require 'securerandom'

require_relative 'erkapharm/configurable'
require_relative 'erkapharm/client'
require_relative 'erkapharm/webhooks'

module Erkapharm
  class << self
    include Configurable

    def client
      return @client if defined?(@client) && @client.same_options?(options)

      @client = Client.new(options)
    end
  end
end
