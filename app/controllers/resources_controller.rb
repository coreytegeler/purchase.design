class ResourcesController < ApplicationController
  require 'rubygems'
  require 'zip'
  require 'open-uri'
  include AccessHelper
  layout_by_action "access", [:index] => "public"
  before_action :confirm_logged_in, :except => [:index, :admin, :download]

  def index
    @resources = Resource.a_to_z
  end

  def admin
    @resources = Resource.a_to_z
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
      flash[:notice] = errors_for(@resource)
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
      flash[:notice] = errors_for(@resource)
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def delete
    @resource = Resource.find(params[:id])
    respond_to do |format|
      format.js { render partial: 'delete', :locals => {:resource => @resource} }
    end
  end

  def destroy
    @resource = Resource.find(params[:id]).destroy
    update_positions
    flash[:notice] = "Resource was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  def download
    @resources = Resource.all
    t = Tempfile.new("temp-#{Time.now}")
    Zip::OutputStream.open(t.path) do |z|
      @resources.each do |resource|
        title = resource.image_file_name
        z.put_next_entry("pcgdresources/#{title}")
        url = resource.image.url
        url_data = open(url)
        z.print IO.read(url_data)
      end
    end

    send_file t.path, :type => 'application/zip',
                      :disposition => 'attachment',
                      :filename => "pcgdresources.zip"                             
    t.close
  end

  private 

    def resource_params
      params.require(:resource).permit(:name, :link, :position, :image)
    end

    def update_positions
      Resource.a_to_z.each_with_index do |f, i|
          f.update_attribute(:position, i+1)
      end
    end

    def array_of_categories
      ['blog', 'video', 'podcast', 'misc']
    end

end