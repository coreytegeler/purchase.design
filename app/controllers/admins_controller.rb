class AdminsController < ApplicationController

  layout "access"
  before_action :confirm_logged_in
  def index
    @admins = Admin.sorted
  end

  def admin
    @admins = Admin.sorted
    @new_admin = Admin.new
    @new_admin.position = Admin.all.count + 1
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      update_positions
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
    if @admin.alma_maters.first
      @admin.alma_maters.first.admin_id = @admin.id
    end
    if @admin.update_attributes(admin_params)
      update_positions
      flash[:notice] = "Admin was updated!"
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
    @admin = Admin.find(params[:id]).destroy
    update_positions
    flash[:notice] = "Admin was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  private 

    def admin_params
      params.require(:admin).permit(:first_name, :last_name, :position, :email, :password)
    end

    def update_positions
      Admin.sorted.each_with_index do |a, i|
          a.update_attribute(:position, i+1)
      end
    end

end