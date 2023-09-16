# frozen_string_literal: true

module ResponseFormatters
  module Paginator
    def paginate(collection, options = {})
      page = (options[:page] || params[:page] || 1).to_i
      per_page = (options[:per_page] || params[:per_page] || 20).to_i
      per_page = 20 if per_page.zero?

      resource = collection.page(page).per(per_page)

      data = if options.key?(:each_serializer)
               ActiveModelSerializers::SerializableResource.new(resource, options)
             else
               resource
             end

      response.headers['Pagination-Page'] = resource.current_page
      response.headers['Pagination-Per-Page'] = resource.limit_value
      response.headers['Pagination-Total-Pages'] = resource.total_pages
      response.headers['Pagination-Total-Objects'] = resource.total_count

      render json: data.as_json, status: :ok
    end

    def peji(cache_key, options = {})
      pagi_data = Rails.cache.fetch(cache_key, expires_in: options[:cache_expires_in] || 1.hour) do
        page = (options[:page] || params[:page] || 1).to_i
        per_page = (options[:per_page] || params[:per_page] || 20).to_i
        per_page = 20 if per_page.zero?

        resource = yield(options).page(page).per(per_page)

        data = if options.key?(:each_serializer)
                 ActiveModelSerializers::SerializableResource.new(resource, options)
               else
                 resource
               end

        {
          data: data.as_json,
          paginate: {
            page: resource.current_page,
            per_page: resource.limit_value,
            total_pages: resource.total_pages,
            total_objects: resource.total_count
          }
        }
      end

      response.headers['Pagination-Page'] = pagi_data[:paginate][:current_page]
      response.headers['Pagination-Per-Page'] = pagi_data[:paginate][:limit_value]
      response.headers['Pagination-Total-Pages'] = pagi_data[:paginate][:total_pages]
      response.headers['Pagination-Total-Objects'] = pagi_data[:paginate][:total_count]

      render json: pagi_data[:data], status: :ok
    end
  end
end
