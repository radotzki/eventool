class ClientSerializer < ActiveModel::Serializer
  attributes :id, :production_id, :first_name, :last_name, :name, :birthdate ,:phone_number, :city, :gender
end
