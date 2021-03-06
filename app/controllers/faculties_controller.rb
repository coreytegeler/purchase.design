class FacultiesController < ApplicationController

  include AccessHelper
  layout_by_action "access", [:index] => "public"
  before_action :confirm_logged_in, :except => [:index, :admin]

  def index
    @faculties = Faculty.a_to_z
  end

  def admin
    @faculties = Faculty.a_to_z
    @faculties.each do |f|
      f.alma_maters.new
    end
    @new_faculty = Faculty.new
    @new_faculty.position = Faculty.all.count + 1
    @new_faculty.alma_maters.new
  end

  def create
    @faculty = Faculty.new(faculty_params)
    @faculty.position = 1
    if @faculty.alma_maters.first
      @faculty.alma_maters.first.faculty_id = @faculty.id
    end
    if @faculty.save
      update_positions
      flash[:notice] = "Faculty was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = errors_for(@faculty)
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def update
    @faculty = Faculty.find(params[:id])
    if @faculty.alma_maters.first
      @faculty.alma_maters.first.faculty_id = @faculty.id
    end
    if @faculty.update_attributes(faculty_params)
      update_positions
      flash[:notice] = "Faculty was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = errors_for(@faculty)
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def delete
    @faculty = Faculty.find(params[:id])
    respond_to do |format|
      format.js { render partial: 'delete', :locals => {:faculty => @faculty} }
    end
  end

  def destroy
    @faculty = Faculty.find(params[:id]).destroy
    update_positions
    flash[:notice] = "Faculty was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  private 

    def faculty_params
      params.require(:faculty).permit(:first_name, :last_name, :position, :email, :link, alma_maters_attributes: [:id, :faculty_id, :college, :degree, :link])
    end

    def update_positions
      Faculty.a_to_z.each_with_index do |f, i|
          f.update_attribute(:position, i+1)
      end
    end

end