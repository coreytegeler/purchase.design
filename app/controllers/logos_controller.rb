class LogosController < ApplicationController
  require 'rubygems'
  require 'zip'
  require 'open-uri'
  include AccessHelper
  layout 'access'
  before_action :confirm_logged_in, :except => [:index, :admin, :download]

  def admin
    @logos = Logo.first_to_last
    @new_logo = Logo.new(:position => 0)
  end

  def create
    @logo = Logo.new(logo_params)
    @logo.position = 1
    if @logo.save
      flash[:notice] = "New logo was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = errors_for(@logo)
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def update
    @logo = Logo.find(params[:id])
    if @logo.update_attributes(logo_params)
      flash[:notice] = "Logo was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = errors_for(@logo)
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def delete
    @logo = Logo.find(params[:id])
    respond_to do |format|
      format.js { render partial: 'delete', :locals => {:logo => @logo} }
    end
  end

  def destroy
    @logo = Logo.find(params[:id]).destroy
    flash[:notice] = "Logo was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  def download
    @logos = Logo.all
    t = Tempfile.new("temp-#{Time.now}")
    Zip::OutputStream.open(t.path) do |z|
      @logos.each_with_index do |logo, i|
        title = 'logo-'+i.to_s
        z.put_next_entry("PurchaseCollegeGraphicDesignLogos/#{title}")
        url = root_url+logo.file.url
        url_data = open(url)
        z.print url_data.read()
      end
    end

    send_file t.path, :type => 'application/zip',
                      :disposition => 'attachment',
                      :filename => "pcgdlogos.zip"                             
    t.close
  end

  private

    def logo_params
      params.require(:logo).permit(:file, :position)
    end

end
