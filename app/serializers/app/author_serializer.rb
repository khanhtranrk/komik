# frozen_string_literal: true

class App::AuthorSerializer < ActiveModel::Serializer
  attributes :id,
             :firstname,
             :lastname,
             :birthday,
             :introduction,
             :image_url

  def image_url
    @instance_options[:base_url] + Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true) if object.image.attached?
  end
end
