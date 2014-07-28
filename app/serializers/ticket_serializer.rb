class TicketSerializer < ActiveModel::Serializer
  attributes :id, :promoter_id, :client_id, :event_id, :event_price_id, :reason, :cashier_id, :arrived
end
