class PeopleController < ApplicationController
  def index
    @people = Person.sorted
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
    @person_count = Person.count + 1
    @groups = Group.order('position ASC')
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      flash[:notice] = "#{@person.name} was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'index')
    else
      @person_count = Person.count + 1
      @groups = Group.order('position ASC')
      render('new')
    end
  end

  def edit
    @person = Person.find(params[:id])
    @person_count = Person.count
    @groups = Group.order('position ASC')
  end

  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(person_params)
      flash[:notice] = "#{@person.name} was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'show', :id => @person.id)
    else
      @person_count = Person.count
      @groups = Group.order('position ASC')
      render('new')
    end
  end

  def delete
    @person = Person.find(params[:id])
  end

  def destroy
    #don't need an instance variable since it is not being called elsewhere
    person = Person.find(params[:id]).destroy
    flash[:notice] = "#{person.name} was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'index')
  end

  private 

    def person_params
      # raises an error if :person is not present
      # allows listed attributes to be mass-assigned
      params.require(:person).permit(:name, :position, :visible, :group_id, :grad_year)
    end

end
