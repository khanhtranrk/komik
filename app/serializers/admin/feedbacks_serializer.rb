# frozen_string_literal: true

class Admin::FeedbacksSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :content,
             :created_at,
             :user

  def user
    ActiveModelSerializers::SerializableResource.new(
      object.user,
      serializer: Admin::UsersSerializer,
      base_url: @instance_options[:base_url]
    )
  end
end
