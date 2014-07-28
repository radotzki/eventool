require "rails_helper"
require "api_helper"

describe "User Permissions" do  

  	it 'get all users' do
	    api_get 'users', 'producer', 1
	    expect(response).to have_http_status(200)
	    JSON.parse(response.body)["users"].each do |usr|
	    	expect(usr["production_id"]).to eq(1)
  		end

	    api_get 'users', 'promoter', 1
	    expect(response).to have_http_status(200)
	    JSON.parse(response.body)["users"].each do |usr|
	    	expect(usr["production_id"]).to eq(1)
  		end

	    api_get 'users', 'cashier', 1
	    expect(response).to have_http_status(200)
	    JSON.parse(response.body)["users"].each do |usr|
	    	expect(usr["production_id"]).to eq(1)
  		end
  	end

  	it 'check a specific user' do
	    api_get 'users/1', 'producer', 1
	    expect(response).to have_http_status(200)
	    api_get 'users/1', 'producer', 2
	    expect(response).to have_http_status(403)

	    api_get 'users/2', 'promoter', 1
	    expect(response).to have_http_status(200)
	    api_get 'users/1', 'promoter', 2
	    expect(response).to have_http_status(403)

	    api_get 'users/2', 'cashier', 1
	    expect(response).to have_http_status(200)
	    api_get 'users/1', 'cashier', 2
	    expect(response).to have_http_status(403)
  	end

  	it 'update a user' do
	    api_put 'users/1', 'producer', 1, "first_name=Test User"
	    expect(response).to have_http_status(200)
	    api_put 'users/2', 'producer', 1, "first_name=Test User"
	    expect(response).to have_http_status(200)

	    api_put 'users/2', 'promoter', 1, "first_name=Test User"
	    expect(response).to have_http_status(200)
	    api_put 'users/1', 'promoter', 1, "first_name=Test User"
	    expect(response).to have_http_status(403)

	    api_put 'users/3', 'cashier', 1, "first_name=Test User"
	    expect(response).to have_http_status(200)
	    api_put 'users/2', 'cashier', 1, "first_name=Test User"
	    expect(response).to have_http_status(403)
  	end

  	it 'delete a user' do
	    api_delete 'users/2', 'producer', 1
	    expect(response).to have_http_status(200)
	    api_delete 'users/6', 'producer', 1
	    expect(response).to have_http_status(403)

	    api_delete 'users/1', 'promoter', 2
	    expect(response).to have_http_status(403)
	    
	    api_delete 'users/1', 'cashier', 2
	    expect(response).to have_http_status(403)
  	end

  	it 'get all tickets' do
	    api_get 'users/1/tickets', 'producer', 1
	    expect(response).to have_http_status(200)
		api_get 'users/1/tickets', 'producer', 2
	    expect(response).to have_http_status(403)   

	    api_get 'users/2/tickets', 'promoter', 1
	    expect(response).to have_http_status(403)
		api_get 'users/1/tickets', 'promoter', 2
	    expect(response).to have_http_status(403)   

		api_get 'users/3/tickets', 'cashier', 1
	    expect(response).to have_http_status(403)
	    api_get 'users/1/tickets', 'cashier', 2
	    expect(response).to have_http_status(403)
  	end  	
end