require "rails_helper"
require "api_helper"

describe "Ticket Permissions" do  

  	it 'get all tickets' do
	    api_get 'clients/1/tickets', 'producer', 1
	    expect(response).to have_http_status(200)
		api_get 'clients/1/tickets', 'producer', 2
	    expect(response).to have_http_status(403)   

	    api_get 'clients/1/tickets', 'promoter', 1
	    expect(response).to have_http_status(200)
		api_get 'clients/1/tickets', 'promoter', 2
	    expect(response).to have_http_status(403)   

	    api_get 'clients/1/tickets', 'cashier', 1
	    expect(response).to have_http_status(200)
	    api_get 'clients/1/tickets', 'cashier', 2
	    expect(response).to have_http_status(403)
  	end

  	it 'check a specific ticket' do
	    api_get 'clients/1/tickets/1', 'producer', 1
	    expect(response).to have_http_status(200)
	    api_get 'clients/4/tickets/9', 'producer', 1
	    expect(response).to have_http_status(403)

	    api_get 'clients/1/tickets/1', 'promoter', 1
	    expect(response).to have_http_status(200)
	    api_get 'clients/4/tickets/9', 'promoter', 1
	    expect(response).to have_http_status(403)

	    api_get 'clients/1/tickets/1', 'cashier', 1
	    expect(response).to have_http_status(200)
	    api_get 'clients/4/tickets/9', 'cashier', 1
	    expect(response).to have_http_status(403)
  	end

  	it 'create a new ticket by producer' do
  		params = {
  			event_id: 2,
  			event_price_id: 4,
  			reason: "Test me"
  		}
	    api_post 'clients/1/tickets', 'producer', 1, params
	    expect(response).to have_http_status(201)
	    api_post 'clients/1/tickets', 'producer', 2, params
	    expect(response).to have_http_status(403)
  	end

  	it 'create a new ticket by promoter' do
  		params = {
  			event_id: 2,
  			event_price_id: 4,
  			reason: "Test me"
  		}
	    api_post 'clients/1/tickets', 'promoter', 1, params
	    expect(response).to have_http_status(201)
	    api_post 'clients/1/tickets', 'promoter', 2, params
	    expect(response).to have_http_status(403)
  	end

  	it 'create a new ticket by cashier' do
  		params = {
  			event_id: 2,
  			event_price_id: 4,
  			reason: "Test me"
  		}

	    api_post 'clients/1/tickets', 'cashier', 1, params
	    expect(response).to have_http_status(403)
  	end

  	it 'update a ticket' do
	    api_put 'clients/1/tickets/1', 'producer', 1, "event_price_id=2"
	    expect(response).to have_http_status(200)
	    api_put 'clients/1/tickets/2', 'producer', 1, "event_price_id=2"
	    expect(response).to have_http_status(200)
	    api_put 'clients/1/tickets/1', 'producer', 2, "event_price_id=2"
	    expect(response).to have_http_status(403)

	    api_put 'clients/1/tickets/2', 'promoter', 1, "event_price_id=2"
	    expect(response).to have_http_status(200)
	    api_put 'clients/1/tickets/1', 'promoter', 1, "event_price_id=2"
	    expect(response).to have_http_status(403)
	    api_put 'clients/1/tickets/1', 'promoter', 2, "event_price_id=2"
	    expect(response).to have_http_status(403)

	    api_put 'clients/1/tickets/1', 'cashier', 1, "event_price_id=2"
	    expect(response).to have_http_status(403)
  	end

  	it 'delete a ticket' do
	    api_delete 'clients/1/tickets/1', 'cashier', 1
	    expect(response).to have_http_status(403)

		api_delete 'clients/1/tickets/2', 'promoter', 2
	    expect(response).to have_http_status(403)
	    api_delete 'clients/1/tickets/1', 'promoter', 1
	    expect(response).to have_http_status(403)
	    api_delete 'clients/1/tickets/2', 'promoter', 1
	    expect(response).to have_http_status(200)
	    
	    api_delete 'clients/1/tickets/1', 'producer', 2
	    expect(response).to have_http_status(403)
	    api_delete 'clients/1/tickets/1', 'producer', 1
	    expect(response).to have_http_status(200)
	    api_delete 'clients/2/tickets/3', 'producer', 1
	    expect(response).to have_http_status(200)
  	end
end