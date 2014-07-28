require "rails_helper"
require "api_helper"

describe "Ticket API" do

  	it 'get all tickets without auth' do
    	get '/api/v1/clients/1/tickets'
    	expect(response).to have_http_status(401)   

    	api_get 'clients/1/tickets', 'lock', 1
	    expect(response).to have_http_status(401) 
  	end    

  	it 'get all tickets' do
	    api_get 'clients/1/tickets', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    json = JSON.parse(response.body)
	    expect(json["tickets"].length).to eq(4)
  	end

  	it 'check a specific ticket' do
	    api_get 'clients/1/tickets/1', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    json = JSON.parse(response.body)
	    expect(json["ticket"]["promoter_id"]).to eq(1)
	    expect(json["ticket"]["client_id"]).to eq(1)
	    expect(json["ticket"]["event_id"]).to eq(1)
	    expect(json["ticket"]["event_price_id"]).to eq(1)
	    expect(json["ticket"]["reason"]).to eq("Good boy!")
	    expect(json["ticket"]["cashier_id"]).to eq(nil)
	    expect(json["ticket"]["arrived"]).to eq(false)

  	end

  	it 'create a new ticket' do
  		params = {
  			event_id: 2,
  			event_price_id: 4,
  			reason: "Test me",
  			cashier_id: 3,
  			arrived: true
  		}
	    api_post 'clients/2/tickets', 'producer', 1, params

	    expect(response).to have_http_status(201)
	    
	    expect(Ticket.last.promoter_id).to eq(1)
	    expect(Ticket.last.client_id).to eq(2)
	    expect(Ticket.last.event_id).to eq(2)
	    expect(Ticket.last.event_price_id).to eq(4)
	    expect(Ticket.last.reason).to eq("Test me")
	    expect(Ticket.last.cashier_id).to eq(3)
	    expect(Ticket.last.arrived).to eq(true)
  	end

  	it 'update a ticket' do
  		params = {
  			event_id: 1,
  			event_price_id: 3,
  			reason: "Test me"
  		}
	    api_put 'clients/1/tickets/1', 'producer', 1, params

	    expect(response).to have_http_status(200)
	    
	    expect(Ticket.find(1).promoter_id).to eq(1)
	    expect(Ticket.find(1).client_id).to eq(1)
	    expect(Ticket.find(1).event_id).to eq(1)
	    expect(Ticket.find(1).event_price_id).to eq(3)
	    expect(Ticket.find(1).reason).to eq("Test me")
	    expect(Ticket.find(1).cashier_id).to eq(nil)
	    expect(Ticket.find(1).arrived).to eq(false)
  	end

  	it 'delete a ticket' do
	    api_delete 'clients/1/tickets/1', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    expect(Ticket.find_by_id(1)).to eq(nil)
  	end

  	it 'client check in' do
	    api_put 'clients/2/tickets/7/checkin', 'cashier', 1

	    expect(response).to have_http_status(200)
	    
	    expect(Ticket.find(7).promoter_id).to eq(2)
	    expect(Ticket.find(7).client_id).to eq(2)
	    expect(Ticket.find(7).event_id).to eq(2)
	    expect(Ticket.find(7).event_price_id).to eq(4)
	    expect(Ticket.find(7).reason).to eq("God")
	    expect(Ticket.find(7).cashier_id).to eq(3)
	    expect(Ticket.find(7).arrived).to eq(true)
  	end  	
end