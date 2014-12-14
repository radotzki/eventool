class API::V1::ClientsController < ApplicationController

  before_action :restrict_access
  load_and_authorize_resource
  
  def index
  	@production = Production.find(current_user.production_id)
    render json: @production.clients, status: :ok
  end

  def show
    @client = Client.find_by_id(params[:id])
    if @client
      render json: @client, status: :ok
    else
      render json: {message: "Client not found."}, status: :not_found
    end
  end

  def create
    @client = Client.new(client_params)
    @client.production_id = current_user.production_id
    if @client.save
      render json: {id: @client.id}, status: :created
    else
      render json: {message: "Client not created.", error: @client.errors}, status: :not_found
    end
  end

  def update
    @client = Client.find_by_id(params[:id])
    if !@client
      render json: {message: "Client not found."}, status: :not_found
    elsif @client.update_attributes(client_params)
      render json: {message: "Client updated."}, status: :ok
    else
      render json: {message: "Client not updated.", error: @client.errors}, status: :no_content
    end
  end

  def destroy
    @client = Client.find_by_id(params[:id]).destroy
    if !@client
      render json: {message: "Client not found."}, status: :not_found
    else    
      render json: {message: "Client destroyed."}, status: :ok
    end
  end

  def search
    render json: Client.search(params[:search_param], current_user.production_id), status: :ok
  end

  private

  def client_params
    params.permit(:id, :production_id, :first_name, :last_name, :birthdate ,:phone_number, :city, :gender)
  end

end
