class Client < ActiveRecord::Base

	belongs_to :production
	has_many :comments, :class_name => "ClientComment", :foreign_key => 'client_id'
	has_many :tickets
	has_many :friend_one, :class_name => 'ClientFriendship', :foreign_key => 'client_one_id'
  	has_many :friend_two, :class_name => 'ClientFriendship', :foreign_key => 'client_two_id'
	
	enum gender: [ :female, :male ]

	validates :first_name, :presence => true,
  	                       :length => { :maximum => 25 }
	validates :last_name, :presence => true,
      	                  :length => { :maximum => 50 }
  	validate :phone_number_is_allowed

	scope :search, lambda {|search_param, production_id| where(["(concat(first_name, ' ', last_name) LIKE ? OR phone_number LIKE ?) AND production_id = ?", "%#{search_param}%", "%#{search_param}%", "#{production_id}"])}

	def friends
  	  friend_one + friend_two
	end  

	def name
		first_name + ' ' + last_name
	end

	def phone_number_is_allowed
		if phone_number != nil
	    	@same_phone = Client.where(:production_id => production_id).where(:phone_number => phone_number).first
	    	if  @same_phone && @same_phone.id != self.id
	      		errors.add(:phone_number, "client exist.")
	    	end
	    end
    end


end

