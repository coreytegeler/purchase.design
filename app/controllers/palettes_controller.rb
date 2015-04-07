class PalettesController < ApplicationController

  layout 'access'
  before_action :confirm_logged_in

  def index
    @palettes = Palette.sorted
  end

  def admin
    @palettes = Palette.sorted
    @new_palette = Palette.new
    @new_palette.name = "New palette"
  end

  def new
    @palette = Palette.new
  end

  def create
    @palette = Palette.new(palette_params)
    if @palette.save
      flash[:notice] = "#{@palette.name} was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      render('new')
    end
  end

  def edit
    #@palette = Palette.find(params[:id])
  end

  def update
    @palette = Palette.find(params[:id])
    if @palette.update_attributes(palette_params)
      flash[:notice] = "#{@palette.name} was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      render('new')
    end
  end

  def delete
    @palette = Palette.find(params[:id])
  end

  def destroy
    #don't need an instance variable since it is not being called elsewhere
    palette = Palette.find(params[:id]).destroy
    flash[:notice] = "#{palette.name} was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'index')
  end

  private

    def palette_params
      # raises an error if :palette is not present
      # allows listed attributes to be mass-assigned
      params.require(:palette).permit(:name, :primary_color, :secondary_color, :position)
    end

end
