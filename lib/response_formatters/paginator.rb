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
  end
end
