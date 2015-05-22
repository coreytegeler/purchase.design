class PalettesController < ApplicationController

  include AccessHelper
  layout 'access'
  before_action :confirm_logged_in, :except => [:index, :admin]

  def admin
    @palettes = Palette.first_to_last
    @new_palette = Palette.new(:position => 0)
    @new_palette.primary_color = "#"
    @new_palette.secondary_color = "#"
  end

  def create
    @palette = Palette.new(palette_params)
    if @palette.save
      flash[:notice] = "Palette was created! <a href='/?palette=#{@palette.id}'>Check it out!</a>"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = errors_for(@palette)
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def update
    @palette = Palette.find(params[:id])
    if @palette.update_attributes(palette_params)
      flash[:notice] = "Palette was updated! <a href='/?palette=#{@palette.id}'>Check it out!</a>"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = errors_for(@palette)
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def delete
    @palette = Palette.find(params[:id])
    respond_to do |format|
      format.js { render partial: 'delete', :locals => {:palette => @palette} }
    end
  end

  def destroy
    @palette = Palette.find(params[:id]).destroy
    flash[:notice] = "Palette was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  private

    def palette_params
      params.require(:palette).permit(:primary_color, :secondary_color, :position)
    end

end
