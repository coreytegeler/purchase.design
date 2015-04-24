class FacultiesController < ApplicationController

  layout_by_action "access", [:index] => "public"
  before_action :confirm_logged_in, :except => [:index]

  def index
    @faculties = Faculty.sorted
  end

  def admin
    @faculties = Faculty.sorted
  end

  def edit
    @faculty = Faculty.find(params[:id])
    @count = Faculty.count
    @faculty.alma_maters.build
  end

  def new
    @faculty = Faculty.new
    @count = Faculty.count + 1
    @faculty.position = @count
    @faculty.alma_maters.build
  end

  def create
    @faculty = Faculty.new(faculty_params)
    if @faculty.save
      flash[:notice] = "#{@faculty.name} was created!"
      flash[:type] = 'good'
      redirect_to(:controller => 'faculties', :action => 'admin')
    else
      @count = Faculty.count + 1
      @faculty.position = @count
      render('new')
    end
  end

  def update
    @faculty = Faculty.find(params[:id])
    if @faculty.update_attributes(faculty_params)
      flash[:notice] = "#{@faculty.name} was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin', :faculty => @faculty)
    else
      @count = Faculty.count
      render('new')
    end
  end

  def delete
    @faculty = Faculty.find(params[:id])
  end

  def destroy
    faculty = Faculty.find(params[:id]).destroy
    flash[:notice] = "#{faculty.name} was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin', :faculty => @faculty)
  end

  private 

    def faculty_params
      params.require(:faculty).permit(:name, :position, :email, :title, :summary, :first_year, :last_year, :current, :visible, alma_maters_attributes: [:id, :college, :degree, :year, :faculty_id, :_destroy])
    end

end