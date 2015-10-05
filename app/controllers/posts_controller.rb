class PostsController < ApplicationController
  require 'rubygems'
  require 'zip'
  require 'open-uri'
  include AccessHelper
  layout_by_action "access", [:index] => "public"
  before_action :confirm_logged_in, :except => [:index, :admin, :download]

  def index
    @posts = Post.new_to_old
  end

  def admin
    @posts = Post.new_to_old
    @posts.each do |f|
      f.post_images.new
      f.position = f.position + 1
    end
    @categories = ['event', 'alumni', 'faculty', 'student']
    @new_post = Post.new(:position => 1)
    @new_post.post_images.new(:position => 1)
    @post_images = PostImage.sorted
  end

  def create
    @post = Post.new(post_params)
    if @post.post_images.first
      @post.post_images.first.post_id = @post.id
    end
    if @post.save
      update_positions
      flash[:notice] = "Post was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = errors_for(@post)
      p @post.errors.full_messages
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      update_positions
      flash[:notice] = "Post was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = errors_for(@post)
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def delete
    @post = Post.find(params[:id])
    respond_to do |format|
      format.js { render partial: 'delete', :locals => {:post => @post} }
    end
  end

  def destroy
    @post = Post.find(params[:id]).destroy
    update_positions
    flash[:notice] = "Post was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  def download
    @posts = Post.all
    t = Tempfile.new("temp-#{Time.now}")
    Zip::OutputStream.open(t.path) do |z|
      @posts.each do |post|
        post.post_images.each do |image|
          title = image.image_file_name
          z.put_next_entry("PurchaseCollegeGraphicDesignPosts/#{title}")
          url = image.image.url
          url_data = open(url)
          z.print IO.read(url_data)
        end
      end
    end

    send_file t.path, :type => 'application/zip',
                      :disposition => 'attachment',
                      :filename => "pcgdposts.zip"                             
    t.close
  end

  private 

    def post_params
      params.require(:post).permit(:title, :position, :body, :category, :start_date, :end_date, post_images_attributes: [:id, :image, :position, :_destroy])
    end

    def update_positions
      Post.new_to_old.each_with_index do |f, i|
          f.update_attribute(:position, i+1)
      end
    end

end