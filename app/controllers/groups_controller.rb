class GroupsController < ApplicationController
  def index
    @groups = Group.sorted
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:notice] = "#{@group.name} was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      flash[:notice] = "#{@group.name} was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'show', :id => @group.id)
    else
      render('new')
    end
  end

  def delete
    @group = Group.find(params[:id])
  end

  def destroy
    #don't need an instance variable since it is not being called elsewhere
    group = Group.find(params[:id]).destroy
    flash[:notice] = "#{group.name} was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'index')
  end

  private 

    def group_params
      # raises an error if :group is not present
      # allows listed attributes to be mass-assigned
      params.require(:group).permit(:name, :position, :visible)
    end

end
