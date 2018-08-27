class CoursesController < ApplicationController

	include AccessHelper
	layout_by_action "access", [:index, :single] => "public"
	before_action :confirm_logged_in, :except => [:index, :admin, :single]

	def index
		@courses = Course.all
		@semesters = ["Semester 1", "Semester 2", "Semester 3", "Semester 4"]
		@years = ["Freshman", "Sophomore", "Junior", "Senior"]
		@course_list = []
		@years.each_with_index do |year, i|
			@years_courses = @courses.where(year: year)
			@course_list[i] = {"name": year, "semesters": []}
			@semesters.each_with_index do |semester, j|
				@semesters_courses = @years_courses.where(semester: semester)
				@course_list[i][:semesters].push({
					"name": semester,
					"courses": @semesters_courses
				})
			end
		end
	end

	def single
		@course = Course.find(params[:id])
	end

	def admin
		@courses = Course.in_order
    @courses.each do |f|
      f.course_images.new
    end
    @new_course = Course.new
    @new_course.position = Course.all.count + 1
    @new_course.course_images.new
    @course_images = CourseImage.sorted
    
		@years = ["Freshman", "Sophomore", "Junior", "Senior"]
		@semesters = ["Semester 1", "Semester 2", "Semester 3", "Semester 4"]
	end

	def create
		@course = Course.new(course_params)
    if @course.course_images.first
      @course.course_images.first.course_id = @course.id
    end
    if @course.save
      update_positions
      flash[:notice] = "Post was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = errors_for(@course)
      p @course.errors.full_messages
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
	end

	def update
		@course = Course.find(params[:id])
		if @course.update_attributes(course_params)
			update_positions
			flash[:notice] = "Course was updated!"
			flash[:type] = 'good'
			redirect_to(:action => 'admin')
		else
			flash[:notice] = errors_for(@course)
			flash[:type] = 'bad'
			redirect_to(:action => 'admin')
		end
	end

	def delete
		@course = Course.find(params[:id])
		respond_to do |format|
			format.js { render partial: 'delete', :locals => {:course => @course} }
		end
	end

	def destroy
		@course = Course.find(params[:id]).destroy
		update_positions
		flash[:notice] = "Course was deleted!"
		flash[:type] = 'good'
		redirect_to(:action => 'admin')
	end

	private 

		def course_params
			params.require(:course).permit(:name, :year, :semester, :about, :required, course_images_attributes: [:id, :image, :position, :_destroy])
		end

		def update_positions
			Course.a_to_z.each_with_index do |c, i|
				c.update_attribute(:position, i+1)
			end
		end

end