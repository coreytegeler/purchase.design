class LogosController < ApplicationController

  layout 'access'
  before_action :confirm_logged_in, :except => [:index, :admin]

  def admin
    @logos = Logo.first_to_last
    @new_logo = Logo.new(:position => 0)
  end

  def create
    @logo = Logo.new(logo_params)
    if @logo.save
      flash[:notice] = "New logo was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Logo was not created!"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def update
    @logo = Logo.find(params[:id])
    if @logo.update_attributes(logo_params)
      flash[:notice] = "Logo was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Logo was not updated!"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def delete
    @logo = Logo.find(params[:id])
    respond_to do |format|
      format.js { render partial: 'delete', :locals => {:logo => @logo} }
    end
  end

  def destroy
    @logo = Logo.find(params[:id]).destroy
    flash[:notice] = "Logo was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  private

    def logo_params
      params.require(:logo).permit(:file, :position)
    end

end
