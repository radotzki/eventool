# Disable for all serializers (except ArraySerializer)
ActiveModel::Serializer.root = false

# Disable for ArraySerializer
ActiveModel::ArraySerializer.root = false

# ActiveModel::Serializer.setup do |config|
#   config.key_format = :lower_camel
# end