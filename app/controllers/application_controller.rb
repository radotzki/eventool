require 'apriori'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

	rescue_from CanCan::AccessDenied do |exception|
	  render json: {:alert => exception.message}, status: :forbidden
	end

	@@mine_result = []

def aprioriCalc(force, event_id)
    # [26,27,28,34,36,37,38,39,49,50]
    if (@@mine_result[event_id].nil? || force) 
    	puts "Calc apriori for event #" + event_id.to_s + ".."
    	@tickets = Ticket.select("client_id", "event_id").where(arrived: true).where.not(event_id: event_id)

    	test_data = {}
    	for i in @tickets
    		if test_data[i.event_id].nil?
    			test_data[i.event_id] = []
    		end
    		test_data[i.event_id].push(i.client_id)
    	end

	    # test_data = {
	    #   1 => [1,2,3,4],
	    #   2 => [1,2,3,5],
	    #   3 => [1,2,3,5,6,7],
	    #   4 => [1,2,3,8,9,10]
	    # }
	    # puts test_data
	    
	    item_set = Apriori::ItemSet.new(test_data)
	    support = 40
	    confidence = 60
	  
	    # item_set.create_association_rules(confidence)
	    @@mine_result[event_id] = item_set.mine(support, confidence)    	
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
