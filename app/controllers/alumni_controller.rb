class AlumniController < ApplicationController

  layout_by_action "access", [:index] => "public"
  before_action :confirm_logged_in, :except => [:index]

  def index
    @alumni = Alumnus.sorted
  end

  def admin
    @alumni = Alumnus.sorted
  end

  def new
    @alumnus = Alumnus.new
    @count = Alumnus.count + 1
  end

  def create
    @alumnus = Alumnus.new(alumnus_params)
    if @alumnus.save
      flash[:notice] = "#{@alumnus.name} was created!"
      flash[:type] = 'good'
      redirect_to(:controller => 'alumni', :action => 'admin')
    else
      @count = Alumnus.count + 1
      render('new')
    end
  end

  def edit
    @alumnus = Alumnus.find(params[:id])
    @count = Alumnus.count
  end

  def update
    @alumnus = Alumnus.find(params[:id])
    if @alumnus.update_attributes(alumnus_params)
      flash[:notice] = "#{@alumnus.name} was updated!"
      flash[:type] = 'good'
      redirect_to(:controller => 'alumni', :action => 'admin')
    else
      @count = Alumnus.count
      render('new')
    end
  end

  def delete
    @alumnus = Alumnus.find(params[:id])
  end

  def destroy
    alumnus = Alumnus.find(params[:id]).destroy
    flash[:notice] = "#{alumnus.name} was deleted!"
    flash[:type] = 'good'
    redirect_to(:controller => 'alumni', :action => 'admin')
  end

  private 

    def alumnus_params
      params.require(:alumnus).permit(:name, :year, :url, :position, :visible)
    end

end