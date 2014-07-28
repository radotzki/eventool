require "rails_helper"
require "api_helper"

describe "EventPrice Permissions" do  

  	it 'get all prices' do
	    api_get 'events/1/prices', 'producer', 1
	    expect(response).to have_http_status(200)
		api_get 'events/1/prices', 'producer', 2
	    expect(response).to have_http_status(403)   

	    api_get 'events/1/prices', 'promoter', 1
	    expect(response).to have_http_status(200)
		api_get 'events/1/prices', 'promoter', 2
	    expect(response).to have_http_status(403)   

		api_get 'events/1/prices', 'cashier', 1
	    expect(response).to have_http_status(200)
	    api_get 'events/1/prices', 'cashier', 2
	    expect(response).to have_http_status(403)
  	end

  	it 'check a specific price' do
	    api_get 'events/1/prices/1', 'producer', 1
	    expect(response).to have_http_status(200)
	    api_get 'events/4/prices/6', 'producer', 1
	    expect(response).to have_http_status(403)

	    api_get 'events/1/prices/1', 'promoter', 1
	    expect(response).to have_http_status(200)
	    api_get 'events/4/prices/6', 'promoter', 1
	    expect(response).to have_http_status(403)

		api_get 'events/1/prices/1', 'cashier', 1
	    expect(response).to have_http_status(200)
	    api_get 'events/4/prices/6', 'cashier', 1
	    expect(response).to have_http_status(403)
  	end

  	it 'create a new price' do
	    api_post 'events/1/prices', 'producer', 1, "price=33"
	    expect(response).to have_http_status(201)
	    api_post 'events/1/prices', 'producer', 2, "price=33"
	    expect(response).to have_http_status(403)
	    
	    api_post 'events/1/prices', 'promoter', 1, "price=33"
	    expect(response).to have_http_status(403)

	    api_post 'events/1/prices', 'cashier', 1, "price=33"
	    expect(response).to have_http_status(403)
  	end

  	it 'update a price' do
	    api_put 'events/1/prices/1', 'producer', 1, "price=12"
	    expect(response).to have_http_status(200)
	    api_put 'events/1/prices/1', 'producer', 2, "price=12"
	    expect(response).to have_http_status(403)

	    api_put 'events/1/prices/1', 'promoter', 1, "price=12"
	    expect(response).to have_http_status(403)

	    api_put 'events/1/prices/1', 'cashier', 1, "price=12"
	    expect(response).to have_http_status(403)
  	end

  	it 'delete a price' do
	    api_delete 'events/1/prices/1', 'producer', 2
	    expect(response).to have_http_status(403)
	    api_delete 'events/1/prices/1', 'producer', 1
	    expect(response).to have_http_status(200)

		api_delete 'events/1/prices/2', 'promoter', 1
	    expect(response).to have_http_status(403)	   
	    
	    api_delete 'events/1/prices/2', 'cashier', 1
	    expect(response).to have_http_status(403)
  	end
end