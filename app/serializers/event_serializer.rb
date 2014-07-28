class EventSerializer < ActiveModel::Serializer
  attributes :id, :production_id, :name, :when
end
