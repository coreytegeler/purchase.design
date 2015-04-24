class LogosController < ApplicationController

  layout 'access'
  before_action :confirm_logged_in, :except => [:index, :admin]

  def index
    @logos = Logo.sorted
  end

  def admin
    @logos = Logo.sorted.reverse_order
    @new_logo = Logo.new
    @new_logo.position = Logo.all.count + 1
    @new_logo.name = name + @new_logo.position.to_s
  end

  def create
    @logo = Logo.new(logo_params)
    if @logo.save
      update_positions
      flash[:notice] = "Logo was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Logo was not created!"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @new_logo = Logo.new
      @new_logo.position = Logo.all.count + 1
      @new_logo.name = name + @new_logo.position.to_s
    end
  end

  def update
    @logo = Logo.find(params[:id])
    if @logo.update_attributes(logo_params)
      update_positions
      flash[:notice] = "Logo was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Logo was not updated!"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @new_logo = Logo.new
      @new_logo.position = Logo.all.count + 1
      @new_logo.name = name + @new_logo.position.to_s
    end
  end

  def delete
    @logo = Logo.find(params[:id])
  end

  def destroy
    @logo = Logo.find(params[:id]).destroy
    update_positions
    flash[:notice] = "Logo was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  private

    def logo_params
      params.require(:logo).permit(:file, :name, :position)
    end

    def update_positions
      Logo.sorted.reverse_order.each_with_index do |l, i|
          l.update_attribute(:position, i+1)
          l.update_attribute(:name, name + l.position.to_s)
      end
    end

    def name
      "Logo No. "
    end

end
