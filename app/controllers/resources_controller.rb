class ResourcesController < ApplicationController

  layout_by_action "access", [:index] => "public"
  before_action :confirm_logged_in, :except => [:index, :admin]

  def index
    @resources = Resource.a_to_z
  end

  def admin
    @resources = Resource.new_to_old
    @categories = array_of_categories
    @new_resource = Resource.new
    @new_resource.position = Resource.all.count + 1
  end

  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      update_positions
      flash[:notice] = "Resource was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Resource was not created!"
      p @resource.errors.full_messages
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @categories = array_of_categories
      @new_resource = Resource.new
      @new_resource.position = Resource.all.count + 1
    end
  end

  def update
    @resource = Resource.find(params[:id])
    if @resource.update_attributes(resource_params)
      update_positions
      flash[:notice] = "Resource was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Resource was not updated!"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @categories = array_of_categories
      @new_resource = Resource.new
      @new_resource.position = Resource.all.count + 1
    end
  end

  def delete
    @resource = Resource.find(params[:id])
  end

  def destroy
    @resource = Resource.find(params[:id]).destroy
    update_positions
    flash[:notice] = "Resource was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  private 

    def resource_params
      params.require(:resource).permit(:name, :link, :category, :position, :image, :id)
    end

    def update_positions
      Resource.sorted.reverse_order.each_with_index do |f, i|
          f.update_attribute(:position, i+1)
      end
    end

    def array_of_categories
      ['blog', 'video', 'podcast', 'misc']
    end

end