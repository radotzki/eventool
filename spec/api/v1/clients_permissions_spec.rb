require "rails_helper"
require "api_helper"

describe "Client Permissions" do  

  	it 'get all clients' do
	    api_get 'clients', 'producer', 1
	    expect(response).to have_http_status(200)
	    JSON.parse(response.body).each do |usr|
	    	expect(usr["production_id"]).to eq(1)
  		end

	    api_get 'clients', 'promoter', 1
	    expect(response).to have_http_status(200)
	    JSON.parse(response.body).each do |usr|
	    	expect(usr["production_id"]).to eq(1)
  		end

	    api_get 'clients', 'cashier', 1
	    expect(response).to have_http_status(200)
	    JSON.parse(response.body).each do |usr|
	    	expect(usr["production_id"]).to eq(1)
  		end
  	end

  	it 'check a specific client' do
	    api_get 'clients/1', 'producer', 1
	    expect(response).to have_http_status(200)
	    api_get 'clients/1', 'producer', 2
	    expect(response).to have_http_status(403)

	    api_get 'clients/1', 'promoter', 1
	    expect(response).to have_http_status(200)
	    api_get 'clients/1', 'promoter', 2
	    expect(response).to have_http_status(403)

	    api_get 'clients/1', 'cashier', 1
	    expect(response).to have_http_status(200)
	    api_get 'clients/1', 'cashier', 2
	    expect(response).to have_http_status(403)
  	end

  	it 'create a new client' do
  		params = {
  			first_name: "Test",
  			last_name: "Client",
  			gender: "male",
  			birthdate: "1993-05-27",
  			city: "Tel Aviv"
  		}
	    api_post 'clients', 'producer', 1, params
	    expect(response).to have_http_status(201)
	    
	    api_post 'clients', 'promoter', 1, params
	    expect(response).to have_http_status(201)

	    api_post 'clients', 'cashier', 1, params
	    expect(response).to have_http_status(201)
  	end

  	it 'update a client' do
	    api_put 'clients/1', 'producer', 1, "first_name=Test Client"
	    expect(response).to have_http_status(200)
	    api_put 'clients/1', 'producer', 2, "first_name=Test Client"
	    expect(response).to have_http_status(403)

	    api_put 'clients/1', 'promoter', 1, "first_name=Test Client"
	    expect(response).to have_http_status(200)
	    api_put 'clients/1', 'promoter', 2, "first_name=Test Client"
	    expect(response).to have_http_status(403)

	    api_put 'clients/1', 'cashier', 1, "first_name=Test Client"
	    expect(response).to have_http_status(403)
	    api_put 'clients/1', 'cashier', 2, "first_name=Test Client"
	    expect(response).to have_http_status(403)
  	end

  	it 'delete a client' do
	    api_delete 'clients/1', 'producer', 2
	    expect(response).to have_http_status(403)
	    api_delete 'clients/1', 'producer', 1
	    expect(response).to have_http_status(200)

		api_delete 'clients/6', 'promoter', 1
	    expect(response).to have_http_status(403)
	    api_delete 'clients/6', 'promoter', 2
	    expect(response).to have_http_status(200)	   
	    
	    api_delete 'clients/2', 'cashier', 2
	    expect(response).to have_http_status(403)
  	end

  	it 'search clients' do
	    api_get 'clients/search', 'producer', 1, 'search_param=ir'
	    expect(response).to have_http_status(200)
	    JSON.parse(response.body).each do |cln|
	    	expect(cln["production_id"]).to eq(1)
  		end

	    api_get 'clients/search', 'promoter', 1, 'search_param=ir'
	    expect(response).to have_http_status(200)
	    JSON.parse(response.body).each do |cln|
	    	expect(cln["production_id"]).to eq(1)
  		end

	    api_get 'clients/search', 'cashier', 1, 'search_param=ir'
	    expect(response).to have_http_status(200)
	    JSON.parse(response.body).each do |cln|
	    	expect(cln["production_id"]).to eq(1)
  		end
  	end  	
end