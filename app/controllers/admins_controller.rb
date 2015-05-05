class AdminsController < ApplicationController

  layout "access"
  before_action :confirm_logged_in

  def admin
    @admins = Admin.a_to_z
    @this_admin = Admin.find(session[:admin_id])
    @new_admin = Admin.new
    @new_admin.position = Admin.all.count + 1
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      flash[:notice] = "Admin was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Admin was not created!"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update_attributes(admin_params)
      flash[:notice] = "Admin was updated! #{@admin.errors.full_messages}"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Admin was not created!"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def delete
    @admin = Admin.find(params[:id])
  end

  def destroy
    @admin = Admin.find(params[:id]).destro
    flash[:notice] = "Admin was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  private 

    def admin_params
      params.require(:admin).permit(:first_name, :last_name, :email, :password)
    end

end