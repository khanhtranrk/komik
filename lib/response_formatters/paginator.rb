# frozen_string_literal: true

module ResponseFormatters
  module Paginator
    def paginate(collection, options = {})
      total_objects = collection.count

      page = (options[:page] || params[:page] || 1).to_i
      per_page = [(options[:per_page] || params[:per_page] || total_objects).to_i, 1].max
      root = options[:root] || collection.klass.name.tableize

      resource = collection.paginate(page:, per_page:)

      data = if options.key?(:each_serializer)
               ActiveModelSerializers::SerializableResource.new(resource, options)
             else
               resource
             end

      total_pages = (total_objects.to_f / per_page).ceil

      resp_data = { status: 'success' }
      resp_data[:message] = options[:message] || :OK
      resp_data[:data] = {
        "#{root}": data,
        paginate: { page:, per_page:, total_pages:, total_objects: }
      }

      render json: resp_data, status: :ok
    end
  end
end
