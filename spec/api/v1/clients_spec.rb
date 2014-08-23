require "rails_helper"
require "api_helper"

describe "Client API" do

  	it 'get all clients without auth' do
    	get '/api/v1/clients'
    	expect(response).to have_http_status(401)   

    	api_get 'clients', 'lock', 1
	    expect(response).to have_http_status(401) 
  	end    

  	it 'get all clients' do
	    api_get 'clients', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    json = JSON.parse(response.body)
	    expect(json.length).to eq(3)
  	end

  	it 'check a specific client' do
	    api_get 'clients/1', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    json = JSON.parse(response.body)
	    expect(json["first_name"]).to eq("Nir")
	    expect(json["last_name"]).to eq("Radotzki")
	    expect(json["production_id"]).to eq(1)
	    expect(json["phone_number"]).to eq("0541324543")
	    expect(json["city"]).to eq("Tel Mond")
	    expect(json["gender"]).to eq("male")
	    expect(json["birthdate"]).to eq("1997-05-21")
  	end

  	it 'create a new client' do
  		params = {
  			first_name: "Test",
  			last_name: "Client",
  			gender: "male",
  			phone_number: "0541232245",
  			birthdate: "1993-05-27",
  			city: "Tel Aviv"
  		}
	    api_post 'clients', 'producer', 1, params

	    expect(response).to have_http_status(201)
	    
	    expect(Client.last.production_id).to eq(1)
	    expect(Client.last.first_name).to eq("Test")
	    expect(Client.last.last_name).to eq("Client")
	    expect(Client.last.gender).to eq("male")
	    expect(Client.last.phone_number).to eq("0541232245")
	    expect(Client.last.birthdate).to eq(Date.new(1993, 05, 27))
	    expect(Client.last.city).to eq("Tel Aviv")
  	end

  	it 'update a client' do
  		params = {
  			first_name: "Test1",
  			last_name: "Client1",
  			gender: "female",
  			phone_number: "0541232241",
  			birthdate: "1993-05-28",
  			city: "Tel Mond"
  		}
	    api_put 'clients/1', 'producer', 1, params

	    expect(response).to have_http_status(200)
	    
	    expect(Client.find(1).production_id).to eq(1)
	    expect(Client.find(1).first_name).to eq("Test1")
	    expect(Client.find(1).last_name).to eq("Client1")
	    expect(Client.find(1).gender).to eq("female")
	    expect(Client.find(1).phone_number).to eq("0541232241")
	    expect(Client.find(1).birthdate).to eq(Date.new(1993, 05, 28))
	    expect(Client.find(1).city).to eq("Tel Mond")
  	end

  	it 'delete a client' do
	    api_delete 'clients/1', 'producer', 1

	    expect(response).to have_http_status(200)
	    
	    expect(Client.find_by_id(1)).to eq(nil)
  	end

  	it 'search clients' do
  		api_get 'clients/search', 'producer', 1, 'search_param=ir'

  		expect(response).to have_http_status(200)

  		json = JSON.parse(response.body)
	    expect(json.length).to eq(2)
  	end
end