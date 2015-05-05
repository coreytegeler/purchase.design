class PatternsController < ApplicationController

  layout 'access'
  before_action :confirm_logged_in, :except => [:index, :admin]

  def index
    @patterns = Pattern.sorted
  end

  def admin
    @patterns = Pattern.sorted.reverse_order
    @new_pattern = Pattern.new
    @new_pattern.position = Pattern.all.count + 1
    @new_pattern.name = name + @new_pattern.position.to_s
  end

  def create
    @pattern = Pattern.new(pattern_params)
    if @pattern.save
      update_positions
      flash[:notice] = "Pattern was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Pattern was not created!"
      p @pattern.errors.full_messages
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @new_pattern = Pattern.new
      @new_pattern.position = Pattern.all.count + 1
      @new_pattern.name = name + @new_pattern.position.to_s
    end
  end

  def update
    @pattern = Pattern.find(params[:id])
    if @pattern.update_attributes(pattern_params)
      update_positions
      flash[:notice] = "Pattern was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Pattern was not updated!"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @new_pattern = Pattern.new
      @new_pattern.position = Pattern.all.count + 1
      @new_pattern.name = name + @new_pattern.position.to_s
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
    update_positions
    flash[:notice] = "Pattern was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  private

    def pattern_params
      params.require(:pattern).permit(:tile, :name, :position)
    end

    def update_positions
      Pattern.sorted.reverse_order.each_with_index do |p, i|
          p.update_attribute(:position, i+1)
          p.update_attribute(:name, name + p.position.to_s)
      end
    end

    def name
      "Pattern No. "
    end

end
