# frozen_string_literal: true

class Admin::PurchaseSerializer < ActiveModel::Serializer
  attributes :id,
             :plan,
             :price,
             :effective_at,
             :expires_at,
             :payment_method,
             :created_at

  def plan
    ActiveModelSerializers::SerializableResource.new(
      object.plan,
      each_serializer: Admin::PlansSerializer
    )
  end
end
