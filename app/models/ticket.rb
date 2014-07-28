class Ticket < ActiveRecord::Base

	belongs_to :promoter, :class_name => "User", :foreign_key => "promoter_id"
	belongs_to :cashier, :class_name => "User", :foreign_key => "cashier_id"
	belongs_to :client
	belongs_to :event
	belongs_to :price, :class_name => "EventPrice", :foreign_key => "event_price_id"

end


