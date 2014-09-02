class EventSerializer < ActiveModel::Serializer
  attributes :id, :production_id, :name, :when, :prices
end
