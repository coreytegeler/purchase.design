class WorksController < ApplicationController

  def index
    @works = Work.sorted
  end

  def show
    @work = Work.find(params[:id])
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:notice] = "#{@work.title} was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    if @work.update_attributes(work_params)
      flash[:notice] = "#{@work.title} was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'show', :id => @work.id)
    else
      render('new')
    end
  end

  def delete
    @work = Work.find(params[:id])
  end

  def destroy
    #don't need an instance variable since it is not being called elsewhere
    work = Work.find(params[:id]).destroy
    flash[:notice] = "#{work.title} was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'index')
  end

  private 

    def work_params
      # raises an error if :work is not present
      # allows listed attributes to be mass-assigned
      params.require(:work).permit(:title, :position, :visible)
    end

end
