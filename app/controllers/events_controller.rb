class EventsController < ApplicationController

  layout 'access'
  before_action :confirm_logged_in, :except => [:index, :admin]

  def index
    @events = Event.sorted
  end

  def admin
    @events = Event.sorted
  end

  def show
    @event = Event.find(params[:id])
    @full_name = @event.name + ' ' + @event.last_name
  end

  def new
    @event = Event.new
    3.times{ @event.event_images.build }
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "#{@event.name} was created!"
      flash[:type] = 'good'
      redirect_to(:controller => 'community', :action => 'admin')
    else
      render('new')
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:notice] = "#{@event.name} was updated!"
      flash[:type] = 'good'
      redirect_to(:controller => 'community', :action => 'admin')
    else
      render('new')
    end
  end

  def delete
    @event = Event.find(params[:id])
  end

  def destroy
    #don't need an instance variable since it is not being called elsewhere
    event = Event.find(params[:id]).destroy
    flash[:notice] = "#{event.name} was deleted!"
    flash[:type] = 'good'
    redirect_to(:controller => 'community', :action => 'admin')
  end

  def event?
    session[:event_id]
  end

  private 

    def event_params
      # raises an error if :event is not present
      # allows listed attributes to be mass-assigned
      params.require(:event).permit(:name, :date, :summary, event_images_attributes: [:image])
    end

end
