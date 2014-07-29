require "rails_helper"
require "api_helper"

describe "Production Permissions" do  

  	it 'get all productions' do
	    api_get 'productions', 'producer', 1
	    expect(response).to have_http_status(200)

	    api_get 'productions', 'promoter', 1
	    expect(response).to have_http_status(200)

	    api_get 'productions', 'cashier', 1
	    expect(response).to have_http_status(200)
  	end

  	it 'check a specific production' do
	    api_get 'productions/2', 'producer', 1
	    expect(response).to have_http_status(200)

	    api_get 'productions/2', 'promoter', 1
	    expect(response).to have_http_status(200)

	    api_get 'productions/2', 'cashier', 1
	    expect(response).to have_http_status(200)
  	end

  	it 'update a production' do
	    api_put 'productions/1', 'producer', 1, "name=Test Production"
	    expect(response).to have_http_status(200)

	    api_put 'productions/2', 'producer', 1, "name=Test Production"
	    expect(response).to have_http_status(403)

	    api_put 'productions/1', 'promoter', 1, "name=Test Production"
	    expect(response).to have_http_status(403)
	    
	    api_put 'productions/1', 'cashier', 1, "name=Test Production"
	    expect(response).to have_http_status(403)
  	end

  	it 'delete a production' do
	    api_delete 'productions/1', 'producer', 1
	    expect(response).to have_http_status(200)

	    api_delete 'productions/2', 'producer', 1
	    expect(response).to have_http_status(403)

	    api_delete 'productions/2', 'promoter', 2
	    expect(response).to have_http_status(403)
	    
	    api_delete 'productions/2', 'cashier', 2
	    expect(response).to have_http_status(403)
  	end
end