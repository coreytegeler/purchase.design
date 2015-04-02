class ResourcesController < ApplicationController

  layout_by_action "access", [:index, :show] => "public"
  before_action :confirm_logged_in, :except => [:index]

  def index
    @resources = Resource.sorted
    @types = ResourceType.sorted
  end

  def admin
    @resources = Resource.sorted
    @types = ResourceType.sorted
  end

  def new
    @resource = Resource.new
    @count = Resource.count + 1
    @types = ResourceType.sorted
  end

  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      flash[:notice] = "#{@resource.name} was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      @count = Resource.count + 1
      render('new')
    end
  end

  def edit
    @resource = Resource.find(params[:id])
    @count = Resource.count
    @types = ResourceType.sorted
  end

  def update
    @resource = Resource.find(params[:id])
    if @resource.update_attributes(resource_params)
      flash[:notice] = "#{@resource.name} was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      @count = Resource.count
      render('new')
    end
  end

  def delete
    @resource = Resource.find(params[:id])
  end

  def destroy
    resource = Resource.find(params[:id]).destroy
    flash[:notice] = "#{resource.name} was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  private 

    def resource_params
      params.require(:resource).permit(:name, :link, :type_id, :caption, :position, :visible)
    end

    def resource_types
      
    end

end