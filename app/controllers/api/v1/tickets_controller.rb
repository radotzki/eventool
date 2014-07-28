class API::V1::TicketsController < ApplicationController

  before_action :restrict_access
  load_and_authorize_resource
  before_action :check_client

  def index
  	render json: @client.tickets, status: :ok
  end

  def show
    @ticket = Client.find_by_id(params[:client_id]).tickets.find_by_id(params[:id])
    if @ticket 
      render json: @ticket, status: :ok
    else
      render json: {message: "Ticket not found."}, status: :not_found
    end
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.client_id = params[:client_id]
    @ticket.promoter_id = current_user.id
    if @ticket.save
      render json: {message: "Ticket created."}, status: :created
    else
      render json: {message: "Ticket not created.", error: @ticket.errors}, status: :not_found
    end
  end

  def update
    @ticket = Client.find_by_id(params[:client_id]).tickets.find_by_id(params[:id])
    if !@ticket
      render json: {message: "Ticket not found."}, status: :not_found
    elsif @ticket.update_attributes(ticket_params)
      render json: {message: "Ticket updated."}, status: :ok
    else
      render json: {message: "Ticket not updated.", error: @ticket.errors}, status: :no_content
    end
  end

  def destroy
    @ticket = Client.find_by_id(params[:client_id]).tickets.find_by_id(params[:id]).destroy
    if !@ticket
      render json: {message: "Ticket not found."}, status: :not_found
    else    
    render json: {message: "Ticket destroyed."}, status: :ok
    end
  end

  def checkin
    @ticket = Client.find_by_id(params[:client_id]).tickets.find_by_id(params[:id])
    if !@ticket
      render json: {message: "Ticket not found."}, status: :not_found
    else
      @ticket.arrived = true
      @ticket.cashier_id = current_user.id
      if @ticket.save
      	render json: {message: "Ticket updated."}, status: :ok
	  else
        render json: {message: "Ticket not updated.", error: @ticket.errors}, status: :no_content
      end
    end
  end

   private

    def ticket_params
      params.permit(:id, :promoter_id, :client_id, :event_id, :event_price_id, :reason, :cashier_id, :arrived)
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
