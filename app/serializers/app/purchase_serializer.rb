# frozen_string_literal: true

class App::PurchaseSerializer < ActiveModel::Serializer
  attributes :id,
             :plan,
             :price,
             :effective_date,
             :expiry_date,
             :payment_method,
             :created_at

  def plan
    ActiveModelSerializers::SerializableResource.new(
      object.plan,
      each_serializer: App::PlansSerializer
    )
  end
end
