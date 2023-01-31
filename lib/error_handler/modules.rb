# frozen_string_literal: true

require 'error_handler/rescuers'
require 'error_handler/errors'
require 'error_handler/response_formatters'

module ErrorHandler
  module Modules
    ActiveSupport.on_load(:action_controller) do
      include ErrorHandler
      include ErrorHandler::Rescuers
      include ErrorHandler::ResponseFormatters::Exposer
    end
  end
end
