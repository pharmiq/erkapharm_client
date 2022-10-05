# frozen_string_literal: true

require_relative 'client/models'

module Erkapharm
  class Client
    include Configurable

    CREATE_APPOINTMENT_PATH = 'doctor_appointment'

    def initialize(options = {})
      CONFIGURATION_OPTIONS.each do |attribute|
        value = options[attribute] || Erkapharm.send(attribute)
        send("#{attribute}=", value)
      end
      connection
    end

    # @param appointment [Erkapharm::Requests::Appointment]
    # @return [Erkapharm::Response::Appointment]
    #
    def create_appointment(appointment)
      response = http_post(CREATE_APPOINTMENT_PATH, params: appointment)
      Responses::Appointment.new(
        JSON.parse(response.body),
      )
    end

    private

    def connection
      @connection ||= Faraday.new(url: api_endpoint) do |connection|
        setup_timeouts!(connection)
        setup_auth!(connection)
        setup_error_handling!(connection)
        setup_log_filters!(connection)
        setup_headers!(connection)

        connection.adapter(Faraday.default_adapter)
      end
    end

    def setup_timeouts!(connection)
      connection.options.open_timeout = open_timeout
      connection.options.timeout = read_timeout
    end

    def setup_auth!(connection)
      connection.request(:authorization, :basic, login, password)
    end

    def setup_error_handling!(connection)
      connection.response(:raise_error)
    end

    def setup_log_filters!(connection)
      options = { headers: true, bodies: true, log_level: :debug }
      connection.response(:logger, logger, options) do |logger|
        logger.filter(/(Authorization: )([^&]+)/, '\1[FILTERED]')
      end
    end

    def setup_headers!(connection)
      connection.headers['Content-Type'] = 'application/json'
    end

    def http_post(resource, params:, headers: {})
      connection.post do |request|
        request.url(resource)
        request.headers.merge!(headers)
        request.body = params.to_json
      end
    end
  end
end
