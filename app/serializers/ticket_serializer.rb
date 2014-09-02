class TicketSerializer < ActiveModel::Serializer
	attributes :id, :promoter, :client, :event, :price, :reason, :cashier, :arrived
end
