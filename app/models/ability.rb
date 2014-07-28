class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    if user.producer?
        # Production
        can [ :read, :create], Production
        can [ :update, :destroy  ], Production, :id => user.production_id

        # User
        can [ :read, :destroy, :update, :tickets ], User, :production_id => user.production_id

        # Client
        can [ :read, :create, :update, :destroy ], Client, :production_id => user.production_id
        can [ :search ], Client

        # Event
        can [ :read, :create, :update, :destroy, :tickets ], Event, :production_id => user.production_id

        # Comment - Other restrictions set in ClientComments Controller
        can [ :read, :create, :update, :destroy ], ClientComment

        # Frineds - Other restrictions set in ClientFriendshipw Controller
        can [ :read, :create, :destroy ], ClientFriendship

        # Price - Other restrictions set in EventPrices Controller
        can [ :read, :create, :update, :destroy ], EventPrice  

        # Ticket - Other restrictions set in Tickets Controller
        can [ :read, :create, :update, :destroy ], Ticket     

    elsif user.promoter?
        # Production
        can [ :read], Production

        # User
        can [ :read ], User, :production_id => user.production_id
        can [ :update ], User, :id => user.id        

        # Client
        can [ :read, :create, :update, :destroy ], Client, :production_id => user.production_id
        can [ :search ], Client

        # Event
        can [ :read, :tickets], Event, :production_id => user.production_id

        # Comment - Other restrictions set in ClientComments Controller
        can [ :read, :create, :update, :destroy ], ClientComment

        # Frineds - Other restrictions set in ClientFriendships Controller
        can [ :read, :create, :destroy ], ClientFriendship

        # Price - Other restrictions set in EventPrices Controller
        can [ :read ], EventPrice

        # Ticket - Other restrictions set in Tickets Controller
        can [ :read, :create ], Ticket
        can [ :update, :destroy ], Ticket, :promoter_id => user.id
        
    elsif user.cashier?
        # Production
        can [ :read ], Production

        # User
        can [ :read ], User, :production_id => user.production_id
        can [ :update ], User, :id => user.id

        # Client
        can [ :read ], Client, :production_id => user.production_id
        can [ :search ], Client

        # Event
        can [ :read, :tickets], Event, :production_id => user.production_id  

        # Comment      

        # Friends

        # Price - Other restrictions set in EventPrices Controller
        can [ :read ], EventPrice

        # Ticket - Other restrictions set in Tickets Controller
        can [ :read, :checkin ], Ticket
    
    end

  end
end
