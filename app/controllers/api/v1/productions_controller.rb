class API::V1::ProductionsController < ApplicationController
  
  before_action :restrict_access
  load_and_authorize_resource 

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
      render json: {message: "Production created."}, status: :created
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

end
