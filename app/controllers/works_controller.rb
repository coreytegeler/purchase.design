class WorksController < ApplicationController

  layout_by_action "access", [:index] => "public"
  before_action :confirm_logged_in, :except => [:index, :admin]

  def index
    @works = Work.first_to_last
  end

  def admin
    @works = Work.last_to_first
    @new_work = Work.new
    @new_work.position = Work.count + 1
    @new_work.name = name + @new_work.position.to_s
    @media_types = ["image", "video"]
  end

  def create
    @work = Work.new(work_params)
    if @work.save

      flash[:notice] = "#{@work.name} was uploaded!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "#{@work.name} was not uploaded!"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def update
    @work = Work.find(params[:id])
    if @work.update_attributes(work_params)

      flash[:notice] = "#{@work.name} was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "#{@work.name} was not updated!"
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
    flash[:notice] = "#{work.name} was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  private 

    def work_params
      params.require(:work).permit(:image, :video, :media_type, :position, :visible)
    end

    def update_positions
      Work.first_to_last.each_with_index do |w, i|
          w.update_attribute(:position, i+1)
      end
    end

    def name
      "Work No. "
    end

end