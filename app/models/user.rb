class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	belongs_to :production
	has_many :comments, :class_name => "ClientComment"
	has_many :events
	has_many :client_friendships
	has_many :tickets, :foreign_key => "promoter_id"

	enum role: [ :producer, :promoter, :cashier ]

	validates :first_name, :presence => true,
                           :length => { :maximum => 25 }
	validates :last_name, :presence => true,
                          :length => { :maximum => 50 }


	def name
		first_name + ' ' + last_name
	end  

	def ensure_authentication_token
		self.authentication_token = generate_authentication_token
		self.save!
		self.authentication_token
	end                      

	private

	def generate_authentication_token
		loop do
			token = Devise.friendly_token
			break token unless User.where(authentication_token: token).first
		end
	end

end
