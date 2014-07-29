require "rails_helper"
require "api_helper"

describe "User API" do

  	it 'get all users without auth' do
    	get '/api/v1/users'
    	expect(response).to have_http_status(401)  

	    api_get 'users', 'lock', 1
	    expect(response).to have_http_status(401) 
  	end    

  	it 'get all users' do
	    api_get 'users', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    json = JSON.parse(response.body)
	    expect(json["users"].length).to eq(4)
  	end

  	it 'check a specific user' do
	    api_get 'users/1', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    json = JSON.parse(response.body)
	    expect(json["user"]["first_name"]).to eq("Producer")
	    expect(json["user"]["last_name"]).to eq("1")
	    expect(json["user"]["production_id"]).to eq(1)
	    expect(json["user"]["phone_number"]).to eq("0541111111")
	    expect(json["user"]["role"]).to eq("producer")
  	end

  	it 'create a new user' do
  		params = {
  			production_id: 1,
  			first_name: "Test",
  			last_name: "User",
  			email: "test@user.com",
  			password: "12345678"
  		}
	    post '/api/v1/users', params

	    expect(response).to have_http_status(201)
	    
	    expect(User.last.first_name).to eq("Test")
	    expect(User.last.last_name).to eq("User")
	    expect(User.last.production_id).to eq(1)
	    expect(User.last.phone_number).to eq(nil)
	    expect(User.last.role).to eq("cashier")
	    expect(User.last.email).to eq("test@user.com")
  	end

  	it 'update a user' do
  		params = {
  			first_name: "Test1",
  			last_name: "User1",
  			email: "test@user1.com",
  			phone_number: "0541234567"
  		}
	    api_put 'users/1', 'producer', 1, params

	    expect(response).to have_http_status(200)
	    
	    expect(User.find(1).first_name).to eq("Test1")
	    expect(User.find(1).last_name).to eq("User1")
	    expect(User.find(1).production_id).to eq(1)
	    expect(User.find(1).phone_number).to eq("0541234567")
	    expect(User.find(1).email).to eq("test@user1.com")
  	end

  	it 'delete a user' do
	    api_delete 'users/1', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    expect(User.find_by_id(1)).to eq(nil)
  	end

  	it 'get all tickets for user' do
  		api_get 'users/1/tickets', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    json = JSON.parse(response.body)
	    expect(json["users"].length).to eq(2)  		
  	end

  	it 'unlock a user' do
		api_put 'users/7/unlock', 'producer', 1  		
		expect(response).to have_http_status(200)

		expect(User.find(7).lock).to eq(false)

  	end
end