class ClientCommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :client_id, :comment, :user, :created_at
end
