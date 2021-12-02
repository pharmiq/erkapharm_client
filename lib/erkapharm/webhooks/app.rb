# frozen_string_literal: true

module Erkapharm
  module Webhooks
    class App
      OK_STATUS_CODE = 200

      attr_reader :logger, :process_notification

      # @param logger [Logger]
      #
      def initialize(logger = Erkapharm.logger, &process_notification)
        @logger = logger
        @process_notification = process_notification
      end

      def call(env)
        request = Rack::Request.new(env)
        body = JSON.parse(request.body.read)
        logger.debug("Incoming request: #{body}")
        notification = Models::Appointment.new(body)
        code, message = process_notification.call(notification)
        body = { code: code, message: message }.to_json
        Rack::Response.new(body, OK_STATUS_CODE)
      end
    end
  end
end
