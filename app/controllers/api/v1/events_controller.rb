class API::V1::EventsController < ApplicationController

  before_action :restrict_access
  load_and_authorize_resource
  
  def index
  	@production = Production.find(current_user.production_id)
    render json: @production.events, status: :ok
  end

  def upcoming
    @production = Production.find(current_user.production_id)
    render json: @production.events.where(['events.when >= ?', Date.today]), status: :ok
  end

  def show
    @event = Event.find_by_id(params[:id])
    if @event
      render json: @event, status: :ok
    else
      render json: {message: "Event not found."}, status: :not_found
    end
  end

  def create
    @event = Event.new(event_params)
    @event.production_id = current_user.production_id
    @event.user_id = current_user.id
    if @event.save
      render json: {id: @event.id}, status: :created
    else
      render json: {message: "Event not created.", error: @event.errors}, status: :not_found
    end
  end

  def update
    @event = Event.find_by_id(params[:id])
    if !@event
      render json: {message: "Event not found."}, status: :not_found
    elsif @event.update_attributes(event_params)
      render json: {message: "Event updated."}, status: :ok
    else
      render json: {message: "Event not updated.", error: @event.errors}, status: :no_content
    end
  end

  def destroy
    @event = Event.find(params[:id]).destroy
    if !@event
      render json: {message: "Event not found."}, status: :not_found
    else    
    render json: {message: "Event destroyed."}, status: :ok
    end
  end

  def tickets
    @event = Event.find_by_id(params[:id])
    render json: @event.tickets, status: :ok
  end

  def count_friends_tickets
    @friends_const = 2
    @events_count = Event.all.count
    @friends = Client.find_by_id(params[:client_id]).friends
    @total_count = 0
    @currnet_count = 0

    for i in @friends
      if i.client_one_id == params[:client_id].to_i
        @friend_id = i.client_two_id
      else
        @friend_id = i.client_one_id
      end

      # current event
      @count = Ticket.joins(:client, :event).where('clients.id' => @friend_id, 'events.id' => params[:id]).count
      if @count > 1
        @currnet_count += (@count - 1) / @friends_const + 1
      else
        @currnet_count += @count
      end

      # all events
      @count = Client.find(@friend_id).tickets.count
      if @count > 1
        @total_count += (@count - 1) / @friends_const + 1
      else
        @total_count += @count
      end
    end

    render json: {average: @total_count / @events_count, current: @currnet_count}, status: :ok
  end

   private

    def event_params
      params.permit(:id, :production_id, :name, :when)
    end

end
