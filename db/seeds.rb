# Production 1
Production.create(:name=>"First Production")

User.create(:production_id=>1, :first_name=>"Producer", :last_name=>"1", :email=>"producer@1.com" ,:password=>"12345678", :phone_number=>"0541111111", :role=>"producer", :lock=>false)
User.create(:production_id=>1, :first_name=>"Promoter", :last_name=>"1", :email=>"promoter@1.com" ,:password=>"12345678", :role=>"promoter", :lock=>false)
User.create(:production_id=>1, :first_name=>"Cashier", :last_name=>"1", :email=>"cashier@1.com" ,:password=>"12345678", :role=>"cashier", :lock=>false)

Client.create(:production_id=>1 ,:first_name=>"Nir", :last_name=>"Radotzki", :gender=>"male", :phone_number=>"0541324543", :city =>"Tel Mond", :birthdate=>"1997-05-21")
Client.create(:production_id=>1 ,:first_name=>"Keren", :last_name=>"Meirov", :gender=>"female")
Client.create(:production_id=>1 ,:first_name=>"May", :last_name=>"Marx", :gender=>"female", :city =>"Ramat Gan", :birthdate=>"1994-01-13")

Event.create(:production_id=>1, :user_id=>1, :name=>"First Event", :when=>"2015-10-10 22:30:00")
Event.create(:production_id=>1, :user_id=>1, :name=>"Second Event", :when=>"2013-06-15 22:30:00")

ClientComment.create(:user_id=>1, :client_id=>1, :comment=>"Very god man!")

ClientFriendship.create(:user_id=>1, :client_one_id=>1, :client_two_id=>2)
ClientFriendship.create(:user_id=>1, :client_one_id=>1, :client_two_id=>3)

EventPrice.create(:event_id=>1, :price=>"10")
EventPrice.create(:event_id=>1, :price=>"30")
EventPrice.create(:event_id=>1, :price=>"50")
EventPrice.create(:event_id=>2, :price=>"0")
EventPrice.create(:event_id=>2, :price=>"50")

Ticket.create(:event_id=>1, :client_id=>1, :promoter_id=>1, :event_price_id=>1, :reason=>"Good boy!")
Ticket.create(:event_id=>1, :client_id=>1, :promoter_id=>2, :event_price_id=>2, :reason=>"Test")
Ticket.create(:event_id=>1, :client_id=>2, :promoter_id=>2, :event_price_id=>1, :reason=>"God")
Ticket.create(:event_id=>1, :client_id=>3, :promoter_id=>2, :event_price_id=>3, :reason=>"Hello")

Ticket.create(:event_id=>2, :client_id=>1, :promoter_id=>1, :event_price_id=>4, :reason=>"Good boy!", :arrived=>true, :cashier_id=>3)
Ticket.create(:event_id=>2, :client_id=>1, :promoter_id=>2, :event_price_id=>5, :reason=>"Test")
Ticket.create(:event_id=>2, :client_id=>2, :promoter_id=>2, :event_price_id=>4, :reason=>"God")
Ticket.create(:event_id=>2, :client_id=>3, :promoter_id=>2, :event_price_id=>4, :reason=>"Hello", :arrived=>true, :cashier_id=>3)

# Production 2
Production.create(:name=>"Second Production")

User.create(:production_id=>2, :first_name=>"Producer", :last_name=>"2", :email=>"producer@2.com" ,:password=>"12345678", :phone_number=>"054222222", :role=>"producer", :lock=>false)
User.create(:production_id=>2, :first_name=>"Promoter", :last_name=>"2", :email=>"promoter@2.com" ,:password=>"12345678", :role=>"promoter", :lock=>false)
User.create(:production_id=>2, :first_name=>"Cashier", :last_name=>"2", :email=>"cashier@2.com" ,:password=>"12345678", :role=>"cashier", :lock=>false)

Client.create(:production_id=>2 ,:first_name=>"Nir", :last_name=>"Radotzki", :gender=>"male", :phone_number=>"0541324543", :city =>"Tel Mond", :birthdate=>"1997-05-21")
Client.create(:production_id=>2 ,:first_name=>"Keren", :last_name=>"Meirov", :gender=>"female")
Client.create(:production_id=>2 ,:first_name=>"May", :last_name=>"Marx", :gender=>"female", :city =>"Ramat Gan", :birthdate=>"1994-01-13")

Event.create(:production_id=>2, :user_id=>4, :name=>"First Event", :when=>"2015-10-10 22:30:00")
Event.create(:production_id=>2, :user_id=>4, :name=>"Second Event", :when=>"2013-06-15 22:30:00")

ClientComment.create(:user_id=>5, :client_id=>4, :comment=>"Very god man! Sec Prod")
ClientComment.create(:user_id=>5, :client_id=>4, :comment=>"Check the Cashier")

ClientFriendship.create(:user_id=>4, :client_one_id=>4, :client_two_id=>5)
ClientFriendship.create(:user_id=>4, :client_one_id=>6, :client_two_id=>5)

EventPrice.create(:event_id=>3, :price=>"10")
EventPrice.create(:event_id=>3, :price=>"50")
EventPrice.create(:event_id=>4, :price=>"0")

Ticket.create(:event_id=>3, :client_id=>4, :promoter_id=>4, :event_price_id=>6, :reason=>"Good boy!", :arrived=>true, :cashier_id=>6)

# Locked user
User.create(:production_id=>1, :first_name=>"Lock", :last_name=>"1", :email=>"lock@1.com" ,:password=>"12345678", :phone_number=>"0541111111", :role=>"producer", :lock=>true)