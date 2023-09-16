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

    def sara(cache_key, options = {})
      data = Rails.cache.fetch(cache_key, expires_in: options[:cache_expires_in] || 2.weeks) do
        resource = yield options

        data = if resource && (options.key?(:serializer) || options.key?(:each_serializer))
                 ActiveModelSerializers::SerializableResource.new(resource, options)
               else
                 resource
               end

        data.as_json
      end

      render json: data || { message: options[:message] || 'Thành công!' },
             status: options[:status] || :ok
    end
  end
end
