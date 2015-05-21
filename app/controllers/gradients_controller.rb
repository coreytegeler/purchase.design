class GradientsController < ApplicationController

  include AccessHelper
  layout 'access'
  before_action :confirm_logged_in, :except => [:index, :admin]

  def admin
    @gradients = Gradient.first_to_last
    @new_gradient = Gradient.new(:position => 1)
  end

  def create
    @gradient = Gradient.new(gradient_params)
    if @gradient.save
      flash[:notice] = "Gradient was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = errors_for(@gradient)
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def update
    @gradient = Gradient.find(params[:id])
    if @gradient.update_attributes(gradient_params)
      flash[:notice] = "Gradient was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = errors_for(@gradient)
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def delete
    @gradient = Gradient.find(params[:id])
    respond_to do |format|
      format.js { render partial: 'delete', :locals => {:gradient => @gradient} }
    end
  end

  def destroy
    @gradient = Gradient.find(params[:id]).destroy
    flash[:notice] = "Gradient was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  private

    def gradient_params
      params.require(:gradient).permit(:file, :name, :position, :id)
    end

end
