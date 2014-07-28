class UserSerializer < ActiveModel::Serializer
  attributes :id, :production_id, :first_name, :last_name, :email, :role, :phone_number
end
