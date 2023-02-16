class Device < ApplicationRecord
  scope :owned_by, ->user {where(login_id: Login.where(user_id: user.try(:id) || user.try(:ids)).ids)}

  belongs_to :login
end
