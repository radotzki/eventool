class API::V1::UsersController < ApplicationController

  before_action :restrict_access, except: :create
  load_and_authorize_resource except: [:create]
  
  def index
  	@production = Production.find(current_user.production_id)
    render json: @production.users, status: :ok
  end

  def show
    @user = User.find_by_id(params[:id])
    if @user 
      render json: @user, status: :ok
    else
      render json: {message: "User not found."}, status: :not_found
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: {message: "User not created.", error: @user.errors}, status: :not_found
    end
  end

  def update
    @user = User.find_by_id(params[:id])
    if !@user
      render json: {message: "User not found."}, status: :not_found
    elsif @user.update_attributes(user_params)
      render json: {message: "User updated."}, status: :ok
    else
      render json: {message: "User not updated.", error: @user.errors}, status: :no_content
    end
  end

  def destroy
    @user = User.find_by_id(params[:id]).destroy
    if @user
      render json: {message: "User destroyed."}, status: :ok
    else    
      render json: {message: "User not found."}, status: :not_found    
    end
  end

  def tickets
    @user = User.find_by_id(params[:id])
    render json: @user.tickets, status: :ok
  end

  def unlock
    @user = User.find_by_id(params[:id])
    if !@user
      render json: {message: "User not found."}, status: :not_found
    else
      @user.lock = false
      if @user.save
        render json: {message: "User updated."}, status: :ok
      else
        render json: {message: "User not updated.", error: @user.errors}, status: :no_content
      end
    end
  end

  def lock
    @user = User.find_by_id(params[:id])
    if !@user
      render json: {message: "User not found."}, status: :not_found
    else
      @user.lock = true
      if @user.save
        render json: {message: "User updated."}, status: :ok
      else
        render json: {message: "User not updated.", error: @user.errors}, status: :no_content
      end
    end
  end

  def change_role
    @user = User.find_by_id(params[:id])
    if !@user
      render json: {message: "User not found."}, status: :not_found
    else
      @user.role = params[:role]
      if @user.save
        render json: {message: "User updated."}, status: :ok
      else
        render json: {message: "User not updated.", error: @user.errors}, status: :no_content
      end      
    end
  end

   private

    def user_params
      params.permit(:production_id, :first_name, :last_name, :email, :password ,:phone_number, :role)
    end

end
