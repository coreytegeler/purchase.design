class PatternsController < ApplicationController
  require 'rubygems'
  require 'zip'
  require 'open-uri'
  include AccessHelper
  layout 'access'
  before_action :confirm_logged_in, :except => [:index, :admin, :download]

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

  def download
    @patterns = Pattern.all
    t = Tempfile.new("temp-#{Time.now}")
    Zip::OutputStream.open(t.path) do |z|
      @patterns.each do |pattern|
        title = pattern.tile_file_name
        z.put_next_entry("PurchaseCollegeGraphicDesignStudentPatterns/#{title}")
        url = pattern.tile.url
        url_data = open(url)
        z.print url_data.read()
      end
    end

    send_file t.path, :type => 'application/zip',
                      :disposition => 'attachment',
                      :filename => "pcgdpatterns.zip"                             
    t.close
  end

  private

    def pattern_params
      params.require(:pattern).permit(:tile, :position)
    end

end
