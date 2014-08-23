require "rails_helper"
require "api_helper"

describe "EventPrice API" do

  	it 'get all prices without auth' do
    	get '/api/v1/events/1/prices'
    	expect(response).to have_http_status(401)   

    	api_get 'events/1/prices', 'lock', 1
	    expect(response).to have_http_status(401) 
  	end    

  	it 'get all prices' do
	    api_get 'events/1/prices', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    json = JSON.parse(response.body)
	    expect(json.length).to eq(3)
  	end

  	it 'check a specific prices' do
	    api_get 'events/1/prices/1', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    json = JSON.parse(response.body)
	    expect(json["event_id"]).to eq(1)
	    expect(json["price"]).to eq(10)

  	end

  	it 'create a new price' do
	    api_post 'events/1/prices', 'producer', 1, "price=100"

	    expect(response).to have_http_status(201)
	    
	    expect(EventPrice.last.event_id).to eq(1)
	    expect(EventPrice.last.price).to eq(100)	    
  	end

  	it 'update a price' do
	    api_put 'events/1/prices/1', 'producer', 1, "price=200"

	    expect(response).to have_http_status(200)
	    
	    expect(EventPrice.find(1).event_id).to eq(1)
	    expect(EventPrice.find(1).price).to eq(200)
  	end

  	it 'delete a price' do
	    api_delete 'events/1/prices/1', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    expect(EventPrice.find_by_id(1)).to eq(nil)
  	end
end