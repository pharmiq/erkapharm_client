# frozen_string_literal: true

require_relative 'client/models'
require_relative 'client/middlewares/handle_connection_error'
require_relative 'client/middlewares/handle_http_error'

module Erkapharm
  class Client
    include Configurable

    CREATE_APPOINTMENT_PATH = 'sber_strah/doctor_appointment'

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
      connection.basic_auth(login, password)
    end

    def setup_error_handling!(connection)
      connection.use(:erkapharm_handle_connection_error)
      connection.response(:erkapharm_handle_http_error)
    end

    def setup_log_filters!(connection)
      connection.response(:logger, logger) do |logger|
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

    def http_get(resource, params = {})
      connection.get do |request|
        request.url(resource)
        request.params.update(params) unless params.empty?
      end
    end
  end
end
