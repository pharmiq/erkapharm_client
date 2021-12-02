# frozen_string_literal: true

require_relative 'models/requests/base'
require_relative 'models/requests/appointment'

require_relative 'models/responses/base'
require_relative 'models/responses/appointment'

module Erkapharm
  Requests = Client::Models::Requests
  Responses = Client::Models::Responses
end
