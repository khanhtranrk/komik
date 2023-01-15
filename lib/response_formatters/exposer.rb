# frozen_string_literal: true

module ResponseFormatters
  module Exposer
    def expose(resource = nil, options = {})
      data = if options.key?(:serializer) || options.key?(:each_serializer)
               options[:adapter] ||= :json
               ActiveModelSerializers::SerializableResource.new(resource, options)
             else
               resource
             end

      resp_data = { status: :success }
      resp_data[:message] = options[:message] || :OK
      resp_data[:data] = data.as_json if data.present?

      render json: resp_data, status: options[:status] || :ok
    end
  end
end
