class PatternsController < ApplicationController

  include AccessHelper
  layout 'access'
  before_action :confirm_logged_in, :except => [:index, :admin]

  def admin
    @patterns = Pattern.first_to_last
    @new_pattern = Pattern.new(:position => 0)
  end

  def create
    @pattern = Pattern.new(pattern_params)
    @pattern.position = 1
    if @pattern.save
      flash[:notice] = "Pattern was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = errors_for(@pattern)
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def update
    @pattern = Pattern.find(params[:id])
    if @pattern.update_attributes(pattern_params)
      flash[:notice] = "Pattern was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = errors_for(@pattern)
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def delete
    @pattern = Pattern.find(params[:id])
      respond_to do |format|
      format.js { render partial: 'delete', :locals => {:pattern => @pattern} }
    end
  end

  def destroy
    @pattern = Pattern.find(params[:id]).destroy
    flash[:notice] = "Pattern was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  private

    def pattern_params
      params.require(:pattern).permit(:tile, :position)
    end

end
