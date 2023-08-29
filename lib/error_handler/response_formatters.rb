# frozen_string_literal: true

module ErrorHandler
  module ResponseFormatters
    module Exposer
      def expose_error(status:, message:, errors:)
        render json: { message:, errors: },
               status:
      end
    end
  end
end
