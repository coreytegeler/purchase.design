class WorksController < ApplicationController
  include AccessHelper
  require 'rubygems'
  require 'zip'
  require 'open-uri'

  layout_by_action "access", [:index] => "public"
  before_action :confirm_logged_in, :except => [:index, :admin]

  def index
    @works = Work.last_to_first
  end

  def admin
    @works = Work.first_to_last
    @new_work = Work.new(:position => 0)
    @media_types = ["image", "video"]
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:notice] = "Work was uploaded!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = errors_for(@work)
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def update
    @work = Work.find(params[:id])
    if @work.update_attributes(work_params)
      flash[:notice] = "Work was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = errors_for(@work)
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def delete
    @work = Work.find(params[:id])
    respond_to do |format|
      format.js { render partial: 'delete', :locals => {:work => @work} }
    end
  end

  def destroy
    work = Work.find(params[:id]).destroy
    flash[:notice] = "Work was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  # def download
  #   @works = Work.all
  #   @works.each do |work|
  #     send_file work.image.path,
  #             :filename => work.image_file_name,
  #             :type => work.image_content_type,
  #             :disposition => 'attachment'
  #   end
  # end  

  def export
    @works = Work.all
    t = Tempfile.new("temp-#{Time.now}")
    Zip::OutputStream.open(t.path) do |z|
      @works.each do |work|
        title = work.image_file_name
        z.put_next_entry("PurchaseCollegeGraphicDesignStudentWork/#{title}")
        url1 = 'http://localhost:3000/'+work.image.url
        url1_data = open(url1)
        z.print IO.read(url1_data)
      end
    end

    send_file t.path, :type => 'application/zip',
                      :disposition => 'attachment',
                      :filename => "pcgdwork.zip"                             
    t.close
  end

  private 

    def work_params
      params.require(:work).permit(:image, :video, :designer, :media_type, :position, :visible)
    end

end