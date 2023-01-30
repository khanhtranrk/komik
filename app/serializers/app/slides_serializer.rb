class App::SlidesSerializer < ActiveModel::Serializer
  attributes :image_url,
             :title,
             :type,
             :reference

  def type
    object.slideable_type
  end

  def reference
    if object.slideable_type.eql?('Comic')
      ActiveModelSerializers::SerializableResource.new(
        object.slideable,
        serializer: App::ComicsSerializer
      )
    else
      ActiveModelSerializers::SerializableResource.new(
        object.slideable,
        serializer: App::LinkSerializer
      )
    end
  end
end
