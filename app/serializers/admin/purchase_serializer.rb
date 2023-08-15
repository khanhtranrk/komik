# frozen_string_literal: true

class Admin::PurchaseSerializer < ActiveModel::Serializer
  attributes :id,
             :plan,
             :price,
             :effective_at,
             :expires_at,
             :payment_method,
             :created_at,
             :owner

  def plan
    ActiveModelSerializers::SerializableResource.new(
      object.plan,
      each_serializer: Admin::PlansSerializer
    )
  end

  def owner
    ActiveModelSerializers::SerializableResource.new(
      object.user,
      each_serializer: Admin::UsersSerializer,
      base_url: @instance_options[:base_url]
    )
  end
end
