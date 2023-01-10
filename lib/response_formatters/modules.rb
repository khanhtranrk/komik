# frozen_string_literal: true

require 'response_formatters/exposer'
require 'response_formatters/paginator'

module ResponseFormatters
  module Modules
    ActiveSupport.on_load(:action_controller) do
      include ResponseFormatters::Exposer
      include ResponseFormatters::Paginator
    end
  end
end
