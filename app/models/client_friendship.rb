class ClientFriendship < ActiveRecord::Base

	belongs_to :user
	belongs_to :client_one, :class_name => "Client"
	belongs_to :client_two, :class_name => "Client"

end
