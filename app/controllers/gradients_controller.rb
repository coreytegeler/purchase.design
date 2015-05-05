class GradientsController < ApplicationController

  layout 'access'
  before_action :confirm_logged_in, :except => [:index, :admin]

  def index
    @gradients = Gradient.sorted
  end

  def admin
    @gradients = Gradient.sorted.reverse_order
    @new_gradient = Gradient.new
    @new_gradient.position = Gradient.all.count + 1
    @new_gradient.name = name + @new_gradient.position.to_s
  end

  def create
    @gradient = Gradient.new(gradient_params)
    if @gradient.save
      update_positions
      flash[:notice] = "Gradient was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Gradient was not created!"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @new_gradient = Gradient.new
      @new_gradient.position = Gradient.all.count + 1
      @new_gradient.name = name + @new_gradient.position.to_s
    end
  end

  def update
    @gradient = Gradient.find(params[:id])
    if @gradient.update_attributes(gradient_params)
      update_positions
      flash[:notice] = "Gradient was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Gradient was not updated!"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @new_gradient = Gradient.new
      @new_gradient.position = Gradient.all.count + 1
      @new_gradient.name = name + @new_gradient.position.to_s
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
    update_positions
    flash[:notice] = "Gradient was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  private

    def gradient_params
      params.require(:gradient).permit(:file, :name, :position)
    end

    def update_positions
      Gradient.sorted.each_with_index do |g, i|
          g.update_attribute(:position, i+1)
          g.update_attribute(:name, name + g.position.to_s)
      end
    end

    def name
      "Gradient No. "
    end

end
