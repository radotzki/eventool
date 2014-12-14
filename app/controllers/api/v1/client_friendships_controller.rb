class API::V1::ClientFriendshipsController < ApplicationController

  before_action :restrict_access
  load_and_authorize_resource except: [:create]
  before_action :check_client_and_user

  def index
    render json: @client.friends, status: :ok
  end

  def count
    render json: @client.friends.size, status: :ok
  end

  def create
  @friendship = ClientFriendship.new(friendship_params)
  @friendship.user_id = current_user.id
  @friendship.client_one_id = params[:client_id]
    if @friendship.save
      render json: {message: "Friendship created."}, status: :created
    else
      render json: {message: "Friendship not created.", error: @friendship.errors}, status: :not_found
    end
  end

  def destroy
    @friendship = ClientFriendship.find_by_id(params[:id]).destroy
    if !@friendship
        render json: {message: "Friendship not found."}, status: :not_found
    else    
      render json: {message: "Friendship destroyed."}, status: :ok
    end
  end

   private

    def friendship_params
      params.permit(:id, :user_id, :client_one_id, :client_two_id)
    end  

    def check_client_and_user
      @client = Client.find_by_id(params[:client_id])
      if !@client
        render json: {message: "Client not found."}, status: :not_found
      elsif @client.production_id != current_user.production_id || current_user.role == "cashier"
        render json: {message: "Unauthorized."}, status: :forbidden
      end
    end

end
