class WorksController < ApplicationController

  layout_by_action "access", [:index] => "public"
  before_action :confirm_logged_in, :except => [:index]

  def index
    @works = Work.sorted
  end

  def admin
    @works = Work.sorted
  end

  def new
    @work = Work.new
    @count = Work.count + 1
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:notice] = "#{@work.name} was created!"
      flash[:type] = 'good'
      redirect_to(:controller => 'students', :action => 'admin')
    else
      @count = Work.count + 1
      render('new')
    end
  end

  def edit
    @work = Work.find(params[:id])
    @count = Work.count
  end

  def update
    @work = Work.find(params[:id])
    if @work.update_attributes(work_params)
      flash[:notice] = "#{@work.name} was updated!"
      flash[:type] = 'good'
      redirect_to(:controller => 'students', :action => 'admin')
    else
      @count = Work.count
      render('new')
    end
  end

  def delete
    @work = Work.find(params[:id])
  end

  def destroy
    #don't need an instance variable since it is not being called elsewhere
    work = Work.find(params[:id]).destroy
    flash[:notice] = "#{work.name} was deleted!"
    flash[:type] = 'good'
    redirect_to(:controller => 'students', :action => 'admin')
  end

  private 

    def work_params
      params.require(:work).permit(:name, :image, :designer, :year, :caption, :position, :visible)
    end

end