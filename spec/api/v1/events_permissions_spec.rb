require "rails_helper"
require "api_helper"

describe "Event Permissions" do  

  	it 'get all events' do
	    api_get 'events', 'producer', 1
	    expect(response).to have_http_status(200)
	    JSON.parse(response.body)["events"].each do |usr|
	    	expect(usr["production_id"]).to eq(1)
  		end

	    api_get 'events', 'promoter', 1
	    expect(response).to have_http_status(200)
	    JSON.parse(response.body)["events"].each do |usr|
	    	expect(usr["production_id"]).to eq(1)
  		end

	    api_get 'events', 'cashier', 1
	    expect(response).to have_http_status(200)
	    JSON.parse(response.body)["events"].each do |usr|
	    	expect(usr["production_id"]).to eq(1)
  		end
  	end

  	it 'check a specific event' do
	    api_get 'events/1', 'producer', 1
	    expect(response).to have_http_status(200)
	    api_get 'events/1', 'producer', 2
	    expect(response).to have_http_status(403)

	    api_get 'events/1', 'promoter', 1
	    expect(response).to have_http_status(200)
	    api_get 'events/1', 'promoter', 2
	    expect(response).to have_http_status(403)

	    api_get 'events/1', 'cashier', 1
	    expect(response).to have_http_status(200)
	    api_get 'events/1', 'cashier', 2
	    expect(response).to have_http_status(403)
  	end

  	it 'create a new event' do
  		params = {
  			name: "Test",
  			when: "2014-04-04"
  		}
	    api_post 'events', 'producer', 1, params
	    expect(response).to have_http_status(201)
	    
	    api_post 'events', 'promoter', 1, params
	    expect(response).to have_http_status(403)

	    api_post 'events', 'cashier', 1, params
	    expect(response).to have_http_status(403)
  	end

  	it 'update a event' do
	    api_put 'events/1', 'producer', 1, "name=Test Event"
	    expect(response).to have_http_status(200)
	    api_put 'events/1', 'producer', 2, "name=Test Event"
	    expect(response).to have_http_status(403)

	    api_put 'events/1', 'promoter', 1, "name=Test Event"
	    expect(response).to have_http_status(403)

	    api_put 'events/1', 'cashier', 1, "name=Test Event"
	    expect(response).to have_http_status(403)
  	end

  	it 'delete a event' do
	    api_delete 'events/1', 'producer', 2
	    expect(response).to have_http_status(403)
	    api_delete 'events/1', 'producer', 1
	    expect(response).to have_http_status(200)

		api_delete 'events/3', 'promoter', 2
	    expect(response).to have_http_status(403)   
	    
	    api_delete 'events/3', 'cashier', 2
	    expect(response).to have_http_status(403)
  	end

  	it 'get all tickets' do
	    api_get 'events/1/tickets', 'producer', 1
	    expect(response).to have_http_status(200)
		api_get 'events/1/tickets', 'producer', 2
	    expect(response).to have_http_status(403)   

	    api_get 'events/1/tickets', 'promoter', 1
	    expect(response).to have_http_status(200)
		api_get 'events/1/tickets', 'promoter', 2
	    expect(response).to have_http_status(403)   

		api_get 'events/1/tickets', 'cashier', 1
	    expect(response).to have_http_status(200)
	    api_get 'events/1/tickets', 'cashier', 2
	    expect(response).to have_http_status(403)
  	end
end