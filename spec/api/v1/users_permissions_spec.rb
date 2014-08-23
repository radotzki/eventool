require "rails_helper"
require "api_helper"

describe "User Permissions" do  

  	it 'get all users' do
	    api_get 'users', 'producer', 1
	    expect(response).to have_http_status(200)
	    JSON.parse(response.body).each do |usr|
	    	expect(usr["production_id"]).to eq(1)
  		end

	    api_get 'users', 'promoter', 1
	    expect(response).to have_http_status(200)
	    JSON.parse(response.body).each do |usr|
	    	expect(usr["production_id"]).to eq(1)
  		end

	    api_get 'users', 'cashier', 1
	    expect(response).to have_http_status(200)
	    JSON.parse(response.body).each do |usr|
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
	    expect(response).to have_http_status(200)
		api_get 'users/1/tickets', 'promoter', 2
	    expect(response).to have_http_status(403)   

		api_get 'users/3/tickets', 'cashier', 1
	    expect(response).to have_http_status(403)
	    api_get 'users/1/tickets', 'cashier', 2
	    expect(response).to have_http_status(403)
  	end  

  	it 'unlock a user' do
  		api_put 'users/7/unlock', 'cashier', 1  		
		expect(User.find(7).lock).to eq(true)

		api_put 'users/7/unlock', 'promoter', 1  		
		expect(User.find(7).lock).to eq(true)

		api_put 'users/7/unlock', 'producer', 1  		
		expect(User.find(7).lock).to eq(false)
  	end	

  	it 'change user role' do
  		api_put 'users/3/change_role', 'cashier', 1, 'role=promoter'
		expect(User.find(3).role).to eq("cashier")  		
		
		api_put 'users/3/change_role', 'promoter', 1, 'role=promoter'
		expect(User.find(3).role).to eq("cashier")  		

		api_put 'users/3/change_role', 'producer', 1, 'role=promoter'
		expect(User.find(3).role).to eq("promoter")  		
  	end  	
end