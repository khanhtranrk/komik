# frozen_string_literal: true

module ErrorHandler
  module ResponseFormatters
    module Exposer
      def expose_error(status:, key:, message:, debug: '')
        render json: { status: 'unsuccess', message:, error: { key:, debug: } },
               status:
      end
    end
  end
end
