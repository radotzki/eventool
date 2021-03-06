class API::V1::EventPricesController < ApplicationController

  before_action :restrict_access
  load_and_authorize_resource except: [:create]
  before_action :check_event
  before_action :check_role, only: [:create]

  def index
    render json: @event.prices, status: :ok
  end

  def show
    @price = Event.find_by_id(params[:event_id]).prices.find_by_id(params[:id])
    if @price 
      render json: @price, status: :ok
    else
      render json: {message: "Price not found."}, status: :not_found
    end
  end

  def create
    @price = EventPrice.new(price_params)
    if @price.save
      render json: {message: "Price created."}, status: :created
    else
      render json: {message: "Price not created.", error: @price.errors}, status: :not_found
    end
  end

  def update
    @price = Event.find_by_id(params[:event_id]).prices.find_by_id(params[:id])
    if !@price
      render json: {message: "Price not found."}, status: :not_found
    elsif @price.update_attributes(price_params)
      render json: {message: "Price updated."}, status: :ok
    else
      render json: {message: "Price not updated.", error: @price.errors}, status: :no_content
    end
  end

  def destroy
    @price = Event.find_by_id(params[:event_id]).prices.find_by_id(params[:id]).destroy
    if !@price
      render json: {message: "Price not found."}, status: :not_found
    else    
    render json: {message: "Price destroyed."}, status: :ok
    end
  end

   private

    def price_params
      params.permit(:id, :event_id, :price)
    end  

    def check_event
      @event = Event.find_by_id(params[:event_id])
      if !@event
        render json: {message: "Event not found."}, status: :not_found
      elsif @event.production_id != current_user.production_id
        render json: {message: "Unauthorized."}, status: :forbidden
      end
    end

    def check_role
      if current_user.role != "producer"
        render json: {message: "Unauthorized."}, status: :forbidden
      end
    end

end
