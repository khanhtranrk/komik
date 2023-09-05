# frozen_string_literal: true

module ImageUrlHelper
  extend ActiveSupport::Concern

  included do
    def make_image_url(base_url, subject)
      case ENV['RAILS_ENV']
      when 'development'
        base_url + Rails.application.routes.url_helpers.rails_blob_url(subject, only_path: true) if subject.attached?
      when 'production'
        subject.url if subject.attached?
      else
        raise 'ENV["RAILS_ENV"] is not set'
      end
    end

    def make_image_urls(base_url, subjects)
      case ENV['RAILS_ENV']
      when 'development'
        subjects.map do |subject|
          base_url + Rails.application.routes.url_helpers.rails_blob_url(subject, only_path: true)
        end
      when 'production'
        subjects.map do |subject|
          subject.url
        end
      else
        raise 'ENV["RAILS_ENV"] is not set'
      end
    end
  end
end
