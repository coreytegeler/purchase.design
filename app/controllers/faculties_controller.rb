class FacultiesController < ApplicationController

  layout_by_action "access", [:index] => "public"
  before_action :confirm_logged_in, :except => [:index, :admin]

  def index
    @faculties = Faculty.sorted
  end

  def admin
    @faculties = Faculty.sorted.reverse_order
    @new_faculty = Faculty.new
    @new_faculty.position = Faculty.all.count + 1
    @new_faculty.name = 'New faculty member'
  end

    def create
    @faculty = Faculty.new(faculty_params)
    if @faculty.save
      update_positions
      flash[:notice] = "Faculty was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Faculty was not created!"
      p @faculty.errors.full_messages
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @new_faculty = Faculty.new
      @new_faculty.position = Faculty.all.count + 1
      @new_faculty.name = 'New faculty member'
    end
  end

  def update
    @faculty = Faculty.find(params[:id])
    if @faculty.update_attributes(faculty_params)
      update_positions
      flash[:notice] = "Faculty was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Faculty was not updated!"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @new_faculty = Faculty.new
      @new_faculty.position = Faculty.all.count + 1
      @new_faculty.name = 'New faculty member'
    end
  end

  def delete
    @faculty = Faculty.find(params[:id])
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
      params.require(:faculty).permit(:name, :position, :email, :title, :summary, :first_year, :last_year, :current, :visible, alma_maters_attributes: [:id, :college, :degree, :year, :faculty_id, :_destroy])
    end

    def update_positions
      Faculty.sorted.reverse_order.each_with_index do |f, i|
          f.update_attribute(:position, i+1)
      end
    end

end