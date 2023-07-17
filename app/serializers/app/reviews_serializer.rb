# frozen_string_literal: true

class App::ReviewsSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :content,
             :created_at,
             :updated_at,
             :user

  def user
    ActiveModelSerializers::SerializableResource.new(
      object.user,
      serializer: App::UserSerializer,
      base_url: @instance_options[:base_url]
    )
  end
end
