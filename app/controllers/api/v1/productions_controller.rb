class API::V1::ProductionsController < ApplicationController
  
  before_action :restrict_access, except: [:create, :index]
  load_and_authorize_resource except: [:create, :index]

  def index
    @productions = Production.all
    render json: @productions, status: :ok
  end

  def show
    @production = Production.find_by_id(params[:id])
    if @production
      render json: @production, status: :ok
    else
      render json: {message: "Production not found."}, status: :not_found
    end
  end

  def create
    @production = Production.new(production_params)
    if @production.save
      # Create user
      @user = User.new(user_params)
      @user.production_id = @production.id
      @user.producer!
      @user.lock = "false"
      if @user.save
        render json: {message: "Production created."}, status: :created
      else
        render json: {message: "User not created.", error: @user.errors}, status: :not_found
      end
    else
      render json: {message: "Production not created.", error: @production.errors}, status: :not_found
    end
  end

  def update
    @production = Production.find_by_id(params[:id])
    if !@production
      render json: {message: "Production not found."}, status: :not_found
    elsif @production.update_attributes(production_params)
      render json: {message: "Production updated."}, status: :ok
    else
      render json: {message: "Production not updated.", error: @production.errors}, status: :no_content
    end
  end

  def destroy
    @production = Production.find(params[:id]).destroy
    if !@production
      render json: {message: "Production not found."}, status: :not_found
    else    
    render json: {message: "Production destroyed."}, status: :ok
    end
  end

   private

    def production_params
      params.permit(:name)
    end

    def user_params
      params.permit(:first_name, :last_name, :email, :password ,:phone_number)
    end

end
