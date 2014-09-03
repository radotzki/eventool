class UserSerializer < ActiveModel::Serializer
  attributes :id, :production_id, :first_name, :last_name, :name, :email, :role, :phone_number, :lock
end
