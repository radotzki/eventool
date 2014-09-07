class TicketSerializer < ActiveModel::Serializer
	attributes :id, :promoter, :client, :event, :price, :event_price_id, :reason, :cashier, :arrived, :created_at
end
