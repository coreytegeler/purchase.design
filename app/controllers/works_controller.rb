class WorksController < ApplicationController

  before_action :find_people

  def index
    @works = Work.where(:person_id => @person.id)
  end

  def show
    @work = Work.find(params[:id])
  end

  def new
    @work = Work.new({:person_id => @person.id})
    @work_count = Work.count + 1
    @people = Person.sorted
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:notice] = "#{@work.title} was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'index', :person_id => @person_id)
    else
      @work_count = Work.count + 1
      @people = Person.sorted
      render('new')
    end
  end

  def edit
    @work = Work.find(params[:id])
    @work_count = Work.count
    @people = Person.sorted
  end

  def update
    @work = Work.find(params[:id])
    if @work.update_attributes(work_params)
      flash[:notice] = "#{@work.title} was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'index', :person_id => @person_id)
    else
      @work_count = Work.count
      @people = Person.sorted
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
    redirect_to(:action => 'index', :person_id => @person_id)
  end

  private 

    def work_params
      # raises an error if :work is not present
      # allows listed attributes to be mass-assigned
      params.require(:work).permit(:title, :slug, :position, :visible, :person_id)
    end

    def find_people
      if params[:person_id]
        @person = Person.find(params[:person_id])
      end
    end

end
