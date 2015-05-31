class WorksController < ApplicationController

  include AccessHelper
  layout_by_action "access", [:index] => "public"
  before_action :confirm_logged_in, :except => [:index, :admin]

  def index
    @works = Work.last_to_first
  end

  def admin
    @works = Work.first_to_last
    @new_work = Work.new(:position => 0, :media_type => 'image')
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

  private 

    def work_params
      params.require(:work).permit(:image, :video, :designer, :media_type, :position, :visible)
    end

end