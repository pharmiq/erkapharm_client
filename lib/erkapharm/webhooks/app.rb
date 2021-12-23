# frozen_string_literal: true

module Erkapharm
  module Webhooks
    class App
      OK_STATUS_CODE = 200

      attr_reader :processor

      def initialize(processor)
        @processor = processor
      end

      def call(env)
        request = Rack::Request.new(env)
        body = JSON.parse(request.body.read)
        notification = Models::Appointment.new(body)
        code, message = processor.call(notification, request)
        body = { code: code, message: message }.to_json
        Rack::Response.new(body, OK_STATUS_CODE).to_a
      end
    end
  end
end
