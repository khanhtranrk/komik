class App::NotificationsSerializer < ActiveModel::Serializer
  attributes :id,
             :message,
             :seen,
             :created_at
end
