class API::V1::ClientCommentsController < ApplicationController

  before_action :restrict_access
  load_and_authorize_resource
  before_action :check_client

  def index
  	render json: @client.comments, status: :ok
  end

  def show
    @comment = Client.find_by_id(params[:client_id]).comments.find_by_id(params[:id])
    if @comment 
      render json: @comment, status: :ok
    else
      render json: {message: "Comment not found."}, status: :not_found
    end
  end

  def create
    @comment = ClientComment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      render json: {message: "Comment created."}, status: :created
    else
      render json: {message: "Comment not created.", error: @comment.errors}, status: :not_found
    end
  end

  def update
    @comment = Client.find_by_id(params[:client_id]).comments.find_by_id(params[:id])
    if !@comment
      render json: {message: "Comment not found."}, status: :not_found
    elsif @comment.update_attributes(comment_params)
      render json: {message: "Comment updated."}, status: :ok
    else
      render json: {message: "Comment not updated.", error: @comment.errors}, status: :no_content
    end
  end

  def destroy
    @comment = Client.find_by_id(params[:client_id]).comments.find_by_id(params[:id]).destroy
    if !@comment
      render json: {message: "Comment not found."}, status: :not_found
    else    
    render json: {message: "Comment destroyed."}, status: :ok
    end
  end

   private

    def comment_params
      params.permit(:id, :user_id, :client_id, :comment)
    end  

    def check_client
      @client = Client.find_by_id(params[:client_id])
      if !@client
        render json: {message: "Client not found."}, status: :not_found
      elsif @client.production_id != current_user.production_id
        render json: {message: "Unauthorized."}, status: :forbidden
      end
    end
end
