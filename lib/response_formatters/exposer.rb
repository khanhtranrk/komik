# frozen_string_literal: true

module ResponseFormatters
  module Exposer
    def expose(resource = nil, options = {})
      data = if resource && (options.key?(:serializer) || options.key?(:each_serializer))
               ActiveModelSerializers::SerializableResource.new(resource, options)
             else
               resource
             end

      render json: data.as_json || { message: options[:message] || 'Thành công!' },
             status: options[:status] || :ok
    end
  end
end
