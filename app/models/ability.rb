class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    if user.producer?
        # Production
        can [ :read, :create], Production
        can [ :update, :destroy  ], Production, :id => user.production_id

        # User
        can [ :read, :destroy, :update, :tickets, :unlock, :lock, :change_role ], User, :production_id => user.production_id

        # Client
        can [ :read, :create, :update, :destroy, :in_event ], Client, :production_id => user.production_id
        can [ :search ], Client

        # Event
        can [ :read, :create, :update, :destroy, :tickets ], Event, :production_id => user.production_id

        # Comment - More restrictions set in the controller
        can [ :read, :update, :create, :destroy ], ClientComment

        # Frineds - More restrictions set in the controller
        can [ :read, :create, :destroy, :count ], ClientFriendship

        # Price - More restrictions set in the controller
        can [ :read, :create, :update, :destroy ], EventPrice  

        # Ticket - More restrictions set in the controller
        can [ :read, :create, :update, :destroy, :checkin, :change_price,  :current_event ], Ticket     

    elsif user.promoter?
        # Production
        can [ :read], Production

        # User
        can [ :read ], User, :production_id => user.production_id
        can [ :update, :tickets ], User, :id => user.id        

        # Client
        can [ :read, :create, :update, :destroy, :in_event ], Client, :production_id => user.production_id
        can [ :search ], Client

        # Event
        can [ :read, :tickets], Event, :production_id => user.production_id

        # Comment - More restrictions set in the controller
        can [ :read, :create, :update, :destroy ], ClientComment

        # Frineds - More restrictions set in the controller
        can [ :read, :create, :destroy, :count ], ClientFriendship

        # Price - More restrictions set in the controller
        can [ :read ], EventPrice

        # Ticket - More restrictions set in the controller
        can [ :read, :create, :current_event ], Ticket
        can [ :update, :destroy, :change_price ], Ticket, :promoter_id => user.id
        
    elsif user.cashier?
        # Production
        can [ :read ], Production

        # User
        can [ :read ], User, :production_id => user.production_id
        can [ :update ], User, :id => user.id

        # Client
        can [ :read, :create, :in_event ], Client, :production_id => user.production_id
        can [ :search ], Client

        # Event
        can [ :read, :tickets], Event, :production_id => user.production_id  

        # Comment - More restrictions set in the controller
        can [ :read, :create, :update ], ClientComment     

        # Friends - More restrictions set in the controller
        can [ :count ], ClientFriendship

        # Price - More restrictions set in the controller
        can [ :read ], EventPrice

        # Ticket - More restrictions set in the controller
        can [ :read, :checkin, :current_event ], Ticket
    
    end

  end
end
