class EventPrice < ActiveRecord::Base

	belongs_to :event
	has_many :tickets, :dependent => :delete_all

end
