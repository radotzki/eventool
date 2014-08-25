require "rails_helper"
require "api_helper"

describe "ClientComment Permissions" do  

	it 'get all comments for producer' do
		api_get 'clients/1/comments', 'producer', 1
		expect(response).to have_http_status(200)
		api_get 'clients/1/comments', 'producer', 2
		expect(response).to have_http_status(403)   
	end

	it 'get all comments for promoter' do
		api_get 'clients/1/comments', 'promoter', 1
		expect(response).to have_http_status(200)
		api_get 'clients/1/comments', 'promoter', 2
		expect(response).to have_http_status(403)   
	end

	it 'get all comments for cashier' do
		api_get 'clients/1/comments', 'cashier', 1
		expect(response).to have_http_status(200)
		api_get 'clients/1/comments', 'cashier', 2
		expect(response).to have_http_status(403)
	end

	it 'check a specific comment for producer' do
		api_get 'clients/1/comments/1', 'producer', 1
		expect(response).to have_http_status(200)
		api_get 'clients/4/comments/2', 'producer', 1
		expect(response).to have_http_status(403)
	end

	it 'check a specific comment for promoter' do
		api_get 'clients/1/comments/1', 'promoter', 1
		expect(response).to have_http_status(200)
		api_get 'clients/4/comments/2', 'promoter', 1
		expect(response).to have_http_status(403)
	end

	it 'check a specific comment for cashier' do
		api_get 'clients/1/comments/1', 'cashier', 1
		expect(response).to have_http_status(200)
		api_get 'clients/4/comments/2', 'cashier', 1
		expect(response).to have_http_status(403)
	end

	it 'create a new comment by producer' do
		params = {comment: "Test"}
		api_post 'clients/1/comments', 'producer', 1, params
		expect(response).to have_http_status(201)
		api_post 'clients/1/comments', 'producer', 2, params
		expect(response).to have_http_status(403)
	end

	it 'create a new comment by promoter' do
		params = {comment: "Test"}
		api_post 'clients/1/comments', 'promoter', 1, params
		expect(response).to have_http_status(201)
		api_post 'clients/1/comments', 'promoter', 2, params
		expect(response).to have_http_status(403)
	end

	it 'create a new comment by cashier' do
		params = {comment: "Test"}
		api_post 'clients/1/comments', 'cashier', 1, params
		expect(response).to have_http_status(201)
		api_post 'clients/1/comments', 'cashier', 2, params
		expect(response).to have_http_status(403)
	end

	it 'update a comment by producer' do
		api_put 'clients/1/comments/1', 'producer', 1, "comment=test"
		expect(response).to have_http_status(200)
		api_put 'clients/1/comments/1', 'producer', 2, "comment=test"
		expect(response).to have_http_status(403)
	end

	it 'update a comment by promoter' do
		api_put 'clients/1/comments/1', 'promoter', 1, "comment=test"
		expect(response).to have_http_status(200)
		api_put 'clients/1/comments/1', 'promoter', 2, "comment=test"
		expect(response).to have_http_status(403)
	end

	it 'update a comment by cashier' do
		api_put 'clients/1/comments/1', 'cashier', 1, "comment=test"
		expect(response).to have_http_status(200)
		api_put 'clients/1/comments/1', 'cashier', 2, "comment=test"
		expect(response).to have_http_status(403)
	end		

	it 'delete a comment by producer' do
		api_delete 'clients/1/comments/1', 'producer', 2
		expect(response).to have_http_status(403)
		api_delete 'clients/1/comments/1', 'producer', 1
		expect(response).to have_http_status(200)
	end

	it 'delete a comment by promoter' do
		api_delete 'clients/4/comments/2', 'promoter', 1
		expect(response).to have_http_status(403)
		api_delete 'clients/4/comments/2', 'promoter', 2
		expect(response).to have_http_status(200)	   
	end

	it 'delete a comment by cashier' do
		api_delete 'clients/4/comments/3', 'cashier', 2
		expect(response).to have_http_status(403)
	end	
end