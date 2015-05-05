class PostsController < ApplicationController

  layout_by_action "access", [:index] => "public"
  before_action :confirm_logged_in, :except => [:index, :admin]

  def index
    @posts = Post.new_to_old
  end

  def admin
    @posts = Post.new_to_old
    @posts.each do |f|
      f.post_images.new
      f.position = f.position + 1
    end
    @categories = array_of_categories
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
      flash[:notice] = "Post was not created! #{@post.errors.full_messages}"
      p @post.errors.full_messages
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @categories = array_of_categories
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
      flash[:notice] = "Post was not updated! #{@post.errors.full_messages}"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @categories = array_of_categories
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

  private 

    def post_params
      params.require(:post).permit(:title, :position, :body, :category, :start_date, :end_date, post_images_attributes: [:id, :image, :position, :_destroy])
    end

    def update_positions
      Post.sorted.new_to_old.each_with_index do |f, i|
          f.update_attribute(:position, i+1)
      end
    end

    def array_of_categories
      ['event', 'alumni', 'faculty', 'student']
    end

end