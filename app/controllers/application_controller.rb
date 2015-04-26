require 'apriori'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

	rescue_from CanCan::AccessDenied do |exception|
	  render json: {:alert => exception.message}, status: :forbidden
	end

	@@mine_result = []

def aprioriCalc(force, event_id)
    if (@@mine_result[event_id].nil? || force) 
    	puts "Calc apriori for event #" + event_id.to_s + ".."
    	
      @current_event_tickets = Ticket.select("client_id", "event_id").where(event_id: event_id)
    	@other_tickets = Ticket.select("client_id", "event_id").where(arrived: true).where.not(event_id: event_id)
      @all_tickets = @current_event_tickets + @other_tickets

    	@test_data = {}
    	for i in @all_tickets
    		if @test_data[i.client_id].nil?
    			@test_data[i.client_id] = []
    		end
    		@test_data[i.client_id].push(i.event_id)
    	end

	    @item_set = Apriori::ItemSet.new(@test_data)
	    @support = 10
	    @confidence = 50
	  
	  	@rules = @item_set.mine(@support, @confidence)

      puts @rules
      
      @filtered_roles = []
	  	for i in @rules
	  		first, rest = i[0].split("=>")
	  		if rest == event_id.to_s
	  			puts first + " => " + rest
          @filtered_roles.push(first.split(",").map(&:to_i))
	  		end
	  	end

      @res = []
      @test_data.each do |key, array|
        if !array.include? event_id
          for i in @filtered_roles
            if (i - array).empty?
              @res.push(Client.find(key))
              break
            end
          end
        end
      end

	    @@mine_result[event_id] = @res
    end

    @@mine_result[event_id]
end

private

def restrict_access
  token = request.headers["token"]
  user = token && User.find_by_authentication_token(token.to_s)
  if user
    sign_in user, store: false
  else
    render json: {}, status: :unauthorized
  end
end

end
