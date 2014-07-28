class Event < ActiveRecord::Base

	belongs_to :creator, :class_name => "User", :foreign_key => "user_id"
	belongs_to :production
	has_many :prices, :class_name => "EventPrice", :foreign_key => "event_id"
	has_many :tickets

end
