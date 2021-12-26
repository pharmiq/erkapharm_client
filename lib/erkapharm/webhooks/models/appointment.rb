# frozen_string_literal: true

module Erkapharm
  module Webhooks
    module Models
      class Good < Base
        property :id
        property :name
        property :qtty
        property :sum
        property :disc
        property :disc_percent
        property :mnn
      end

      class Medication < Base
        property :rowId, from: :row_id
        property :qtty_sold, from: :qttySold
        property :sum_sold, from: :sumSold
        property :disc_sold, from: :discSold
        property :disc_percent_sold, from: :discPercentSold
        property :goods, coerce: Array[Good]
      end

      class Appointment < Base
        property :request_id, from: :requestId
        property :order_id, from: :orderId
        property :doctor_appointment_id, from: :doctorAppointmentId
        property :order_sum, from: :orderSum
        property :order_discount, from: :orderDiscount
        property :order_discount_percent, from: :orderDiscountPercent
        property :basket, coerce: Array[Medication]
      end
    end
  end
end
