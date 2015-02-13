class AdminsController < ApplicationController
  def index
    @admins = Admin.sorted
  end

  def show
    @admin = Admin.find(params[:id])
    @full_name = @admin.first_name + ' ' + @admin.last_name
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      flash[:notice] = "#{@admin.first_name} was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update_attributes(admin_params)
      flash[:notice] = "#{@admin.first_name} was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'show', :id => @admin.id)
    else
      render('new')
    end
  end

  def delete
    @admin = Admin.find(params[:id])
  end

  def destroy
    #don't need an instance variable since it is not being called elsewhere
    admin = Admin.find(params[:id]).destroy
    flash[:notice] = "#{@admin.first_name} was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'index')
  end

  private 

    def admin_params
      # raises an error if :admin is not present
      # allows listed attributes to be mass-assigned
      params.require(:admin).permit(:first_name, :last_name, :username, :hashed_password, :email)
    end

end
