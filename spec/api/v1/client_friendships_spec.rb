require "rails_helper"
require "api_helper"

describe "ClientFriendship API" do

  	it 'get all frinds without auth' do
    	get '/api/v1/clients/1/friends'
    	expect(response).to have_http_status(401)   

    	api_get 'clients/1/friends', 'lock', 1
	    expect(response).to have_http_status(401) 
  	end    

  	it 'get all friends' do
	    api_get 'clients/1/friends', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    json = JSON.parse(response.body)
	    expect(json.length).to eq(2)
  	end

  	it 'create a new friendship' do
	    api_post 'clients/2/friends', 'producer', 1, "client_two_id=3"

	    expect(response).to have_http_status(201)
	    
	    expect(ClientFriendship.last.user_id).to eq(1)
	    expect(ClientFriendship.last.client_one_id).to eq(2)
	    expect(ClientFriendship.last.client_two_id).to eq(3)	    
  	end

  	it 'delete a friendship' do
	    api_delete 'clients/1/friends/1', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    expect(ClientFriendship.find_by_id(1)).to eq(nil)
	    expect(ClientFriendship.all.size).to eq(3)
  	end
end