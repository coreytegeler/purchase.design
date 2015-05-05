class PalettesController < ApplicationController

  layout 'access'
  before_action :confirm_logged_in, :except => [:index, :admin]

  def index
    @palettes = Palette.sorted
  end

  def admin
    @palettes = Palette.sorted
    @new_palette = Palette.new
    @new_palette.position = Palette.all.count+1
    @new_palette.name = name + @new_palette.position.to_s
    @new_palette.primary_color = "#"
    @new_palette.secondary_color = "#"
  end

  def new
    @palette = Palette.new
  end

  def create
    @palette = Palette.new(palette_params)
    if @palette.save
      update_positions
      flash[:notice] = "Palette was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Palette was not created!"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @new_palette = Palette.new
      @new_palette.position = Palette.all.count + 1
      @new_palette.name = name + @new_palette.position.to_s
      @new_palette.primary_color = "#"
      @new_palette.secondary_color = "#"
    end
  end

  def update
    @palette = Palette.find(params[:id])
    if @palette.update_attributes(palette_params)
      update_positions
      flash[:notice] = "Palette was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Palette was not updated!"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @new_palette = Palette.new
      @new_palette.position = Palette.all.count+1
      @new_palette.name = name + @new_palette.position.to_s
      @new_palette.primary_color = "#"
      @new_palette.secondary_color = "#"
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
    update_positions
    flash[:notice] = "Palette was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  private

    def palette_params
      # raises an error if :palette is not present
      # allows listed attributes to be mass-assigned
      params.require(:palette).permit(:name, :primary_color, :secondary_color, :position)
    end

    def update_positions
      Palette.old_to_new.each_with_index do |p, i|
          p.update_attribute(:position, i+1)
          p.update_attribute(:name, name + p.position.to_s)
      end
    end

    def name
      "Palete No. "
    end

end
