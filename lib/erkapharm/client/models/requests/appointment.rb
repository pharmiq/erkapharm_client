# frozen_string_literal: true

module Erkapharm
  class Client
    module Models
      module Requests
        class Medication < Base
          property :rowId, from: :row_id
          property :doctorsAppointment, from: :doctors_appointment, required: true
          property :confirmed, required: true
          property :sumAllow, from: :sum_allow
        end

        class Appointment < Base
          property :requestId, from: :request_id, default: -> { SecureRandom.uuid }
          property :requestDate, from: :request_date, default: -> { Time.now.iso8601 }
          property :requestSumAllow, from: :request_sum_allow, required: true
          property :clientName, from: :client_name, required: true
          property :clientTel, from: :client_tel, required: true
          property :basket, coerce: Array[Medication]
        end
      end
    end
  end
end
