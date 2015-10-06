class GradientsController < ApplicationController
  require 'rubygems'
  require 'zip'
  require 'open-uri'
  include AccessHelper
  layout 'access'
  before_action :confirm_logged_in, :except => [:index, :admin, :download]

  def admin
    @gradients = Gradient.first_to_last
    position = @gradients.last.position + 1
    @new_gradient = Gradient.new(:position => position)
  end

  def create
    @gradients = Gradient.first_to_last
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

  def download
    @gradients = Gradient.all
    t = Tempfile.new("temp-#{Time.now}")
    Zip::OutputStream.open(t.path) do |z|
      @gradients.each_with_index do |gradient, i|
        title = 'gradient-'+i.to_s+'.svg'
        z.put_next_entry("pcgdgradients/#{title}")
        url = gradient.file.url
        url_data = open(url)
        z.print url_data.read()
      end
    end
    send_file t.path, :type => 'application/zip',
                      :disposition => 'attachment',
                      :filename => "pcgdgradients.zip" 
    t.close
  end

  private

    def gradient_params
      params.require(:gradient).permit(:file, :name, :position, :id)
    end

end
