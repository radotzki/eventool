require "rails_helper"
require "api_helper"

describe "Production API" do

  	it 'get all productions without auth' do
    	get '/api/v1/productions'
    	expect(response).to have_http_status(401)   

	    api_get 'productions', 'lock', 1
	    expect(response).to have_http_status(401) 
  	end    

  	it 'get all productions' do
	    api_get 'productions', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    json = JSON.parse(response.body)
	    expect(json.length).to eq(2)
  	end

  	it 'check a specific production' do
	    api_get 'productions/1', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    json = JSON.parse(response.body)
	    expect(json["name"]).to eq("First Production")
  	end

  	it 'create a new production' do
	    post 'api/v1/productions', "name=Test Production"

	    expect(response).to have_http_status(201)
	    
	    expect(Production.last.name).to eq("Test Production")
  	end

  	it 'update a production' do
	    api_put 'productions/1', 'producer', 1, "name=Test Production"

	    expect(response).to have_http_status(200)
	    
	    expect(Production.find(1).name).to eq("Test Production")
  	end

  	it 'delete a production' do
	    api_delete 'productions/1', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    expect(Production.find_by_id(1)).to eq(nil)
  	end
end