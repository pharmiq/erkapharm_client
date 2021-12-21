# frozen_string_literal: true

module Erkapharm
  class Client
    module Models
      module Responses
        class Appointment < Base
          property :error_code, from: :errorCode
          property :message
          property :doctor_appointment_id, from: :doctorAppointmentId
        end
      end
    end
  end
end
