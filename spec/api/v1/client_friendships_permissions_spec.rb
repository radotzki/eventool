require "rails_helper"
require "api_helper"

describe "ClientFriendship Permissions" do  

  	it 'get all friends' do
	    api_get 'clients/1/friends', 'producer', 1
	    expect(response).to have_http_status(200)
		api_get 'clients/1/friends', 'producer', 2
	    expect(response).to have_http_status(403)   

	    api_get 'clients/1/friends', 'promoter', 1
	    expect(response).to have_http_status(200)
		api_get 'clients/1/friends', 'promoter', 2
	    expect(response).to have_http_status(403)   

	    api_get 'clients/1/friends', 'cashier', 1
	    expect(response).to have_http_status(403)
  	end

  	it 'create a new friend' do
	    api_post 'clients/2/friends', 'producer', 2, "client_two_id=3"
	    expect(response).to have_http_status(403)
	    api_post 'clients/2/friends', 'producer', 1, "client_two_id=3"
	    expect(response).to have_http_status(201)
	    
	    api_post 'clients/4/friends', 'promoter', 1, "client_two_id=6"
	    expect(response).to have_http_status(403)
	    api_post 'clients/4/friends', 'promoter', 2, "client_two_id=6"
	    expect(response).to have_http_status(201)	   

	    api_post 'clients/2/friends', 'cashier', 1, "client_two_id=3"
	    expect(response).to have_http_status(403)
  	end

  	it 'delete a friend' do
	    api_delete 'clients/1/friends/1', 'producer', 2
	    expect(response).to have_http_status(403)
	    api_delete 'clients/1/friends/1', 'producer', 1
	    expect(response).to have_http_status(200)

		api_delete 'clients/4/friends/3', 'promoter', 1
	    expect(response).to have_http_status(403)
	    api_delete 'clients/4/friends/3', 'promoter', 2
	    expect(response).to have_http_status(200)	   
	    
	    api_delete 'clients/1/friends/2', 'cashier', 1
	    expect(response).to have_http_status(403)
  	end
end