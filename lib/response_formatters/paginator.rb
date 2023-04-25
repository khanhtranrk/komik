# frozen_string_literal: true

module ResponseFormatters
  module Paginator
    def paginate(collection, options = {})
      page = (options[:page] || params[:page] || 1).to_i
      per_page = (options[:per_page] || params[:per_page] || 20).to_i
      per_page = 20 if per_page.zero?
      root = options[:root] || collection.klass.name.tableize

      resource = collection.page(page).per(per_page)

      data = if options.key?(:each_serializer)
               ActiveModelSerializers::SerializableResource.new(resource, options)
             else
               resource
             end

      resp_data = { status: 'success' }
      resp_data[:message] = options[:message] || :OK
      resp_data[:data] = {
        "#{root}": data,
        paginate: {
          page: resource.current_page,
          per_page: resource.limit_value,
          total_pages: resource.total_pages,
          total_objects: resource.total_count
        }
      }

      render json: resp_data, status: :ok
    end
  end
end
