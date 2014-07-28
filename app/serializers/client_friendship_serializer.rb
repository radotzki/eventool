class ClientFriendshipSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :client_one_id, :client_two_id
end
