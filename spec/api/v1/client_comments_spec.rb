require "rails_helper"
require "api_helper"

describe "ClientComment API" do

  	it 'get all comments without auth' do
    	get '/api/v1/clients/1/comments'
    	expect(response).to have_http_status(401)   

    	api_get 'clients/1/comments', 'lock', 1
	    expect(response).to have_http_status(401) 
  	end    

  	it 'get all comments' do
	    api_get 'clients/1/comments', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    json = JSON.parse(response.body)
	    expect(json.length).to eq(1)
  	end

  	it 'check a specific comments' do
	    api_get 'clients/1/comments/1', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    json = JSON.parse(response.body)
	    expect(json["user_id"]).to eq(1)
	    expect(json["client_id"]).to eq(1)
	    expect(json["comment"]).to eq("Very god man!")

  	end

  	it 'create a new comment' do
  		params = {
  			comment: "Test"
  		}
	    api_post 'clients/1/comments', 'producer', 1, params

	    expect(response).to have_http_status(201)
	    
	    expect(ClientComment.last.user_id).to eq(1)
	    expect(ClientComment.last.client_id).to eq(1)
	    expect(ClientComment.last.comment).to eq("Test")	    
  	end

  	it 'update a comment' do
  		params = {
  			comment: "Test1"
  		}
	    api_put 'clients/1/comments/1', 'producer', 1, params

	    expect(response).to have_http_status(200)
	    
	    expect(ClientComment.find(1).user_id).to eq(1)
	    expect(ClientComment.find(1).client_id).to eq(1)
	    expect(ClientComment.find(1).comment).to eq("Test1")
  	end

  	it 'delete a comment' do
	    api_delete 'clients/1/comments/1', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    expect(ClientComment.find_by_id(1)).to eq(nil)
  	end
end