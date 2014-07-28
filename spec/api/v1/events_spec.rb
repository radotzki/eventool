require "rails_helper"
require "api_helper"

describe "Event API" do

  	it 'get all events without auth' do
    	get '/api/v1/events'
    	expect(response).to have_http_status(401)   

    	api_get 'events', 'lock', 1
	    expect(response).to have_http_status(401) 
  	end    

  	it 'get all events' do
	    api_get 'events', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    json = JSON.parse(response.body)
	    expect(json["events"].length).to eq(2)
  	end

  	it 'check a specific event' do
	    api_get 'events/1', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    json = JSON.parse(response.body)
	    expect(json["event"]["name"]).to eq("First Event")
	    # expect(json["event"]["when"]).to eq(DateTime.new(2015, 10, 10, 22, 30, 00))	    
  	end

  	it 'create a new event' do
  		params = {
  			name: "Test",
  			when: "2014-04-04 20:10:10"
  		}
	    api_post 'events', 'producer', 1, params

	    expect(response).to have_http_status(201)
	    
	    expect(Event.last.name).to eq("Test")
	    expect(Event.last.when).to eq(DateTime.new(2014, 04, 04, 20, 10, 10)) 
  	end

  	it 'update an event' do
  		params = {
  			name: "Test",
  			when: "2014-04-04 20:10:10"
  		}
	    api_put 'events/1', 'producer', 1, params

	    expect(response).to have_http_status(200)
	    
	    expect(Event.find(1).name).to eq("Test")
	    expect(Event.find(1).when).to eq(DateTime.new(2014, 04, 04, 20, 10, 10))
  	end

  	it 'delete an event' do
	    api_delete 'events/1', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    expect(Event.find_by_id(1)).to eq(nil)
  	end

  	it 'get all tickets without auth' do
    	get '/api/v1/events/1/tickets'
    	expect(response).to have_http_status(401)   

    	api_get 'events/1/tickets', 'lock', 1
	    expect(response).to have_http_status(401) 
  	end    

  	it 'get all tickets' do
	    api_get 'events/1/tickets', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    json = JSON.parse(response.body)
	    expect(json["events"].length).to eq(4)
  	end  	
end