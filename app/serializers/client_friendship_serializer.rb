class ClientFriendshipSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :client_one, :client_two, :created_at
end
