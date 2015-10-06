class AlumniController < ApplicationController
  require 'rubygems'
  require 'zip'
  require 'open-uri'
  include AccessHelper
  layout_by_action "access", [:index] => "public"
  before_action :confirm_logged_in, :except => [:index, :admin, :download]

  def index
    @alumni = Alumnus.first_to_last
  end

  def admin
    @alumni = Alumnus.first_to_last
    @new_alumnus = Alumnus.new(:position => 0)
  end

  def create
    @alumnus = Alumnus.new(alumnus_params)
    @alumnus.position = 1
    if @alumnus.save
      flash[:notice] = "Alumnus was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = errors_for(@alumnus)
      p @alumnus.errors.full_messages
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @new_alumnus = Alumnus.new
      @new_alumnus.position = Alumnus.all.count + 1
    end
  end

  def update
    @alumnus = Alumnus.find(params[:id])
    if @alumnus.update_attributes(alumnus_params)
      flash[:notice] = "Alumnus was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = errors_for(@alumnus)
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @new_alumnus = Alumnus.new
      @new_alumnus.position = Alumnus.all.count + 1
    end
  end

  def delete
    @alumnus = Alumnus.find(params[:id])
    respond_to do |format|
      format.js { render partial: 'delete', :locals => {:alumnus => @alumnus} }
    end
  end

  def destroy
    @alumnus = Alumnus.find(params[:id]).destroy
    flash[:notice] = "Alumnus was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  def download
    @alumni = Alumnus.all
    t = Tempfile.new("temp-#{Time.now}")
    Zip::OutputStream.open(t.path) do |z|
      @alumni.each do |alumnus|
        title = alumnus.image_file_name
        z.put_next_entry("pcgdalumni/#{title}")
        url = 'http://localhost:3000'+alumnus.image.url
        url_data = open(url)
        z.print File.read(url_data)
      end
    end

    send_file t.path, :type => 'application/zip',
                      :disposition => 'attachment',
                      :filename => "pcgdalumni.zip"                             
    t.close
  end

  private 

    def alumnus_params
      params.require(:alumnus).permit(:first_name, :last_name, :link, :position, :image, :id)
    end

end