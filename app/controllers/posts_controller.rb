class PostsController < ApplicationController

  def index
    @posts = Post.sorted
  end

  def show
    @post = Post.find(params[:id])
    @groups = @post.groups
  end

  def new
    @post = Post.new
    @groups = Group.order('position ASC')
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "#{@post.title} was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'index')
    else
      @groups = Group.order('position ASC')
      render('new')
    end
  end

  def edit
    @post = Post.find(params[:id])
    @groups = Group.order('position ASC')
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:notice] = "#{@post.title} was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'show', :id => @post.id)
    else
      @groups = Group.order('position ASC')
      render('new')
    end
  end

  def delete
    @post = Post.find(params[:id])
  end

  def destroy
    #don't need an instance variable since it is not being called elsewhere
    post = Post.find(params[:id]).destroy
    flash[:notice] = "#{post.title} was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'index')
  end

  private 

    def post_params
      # raises an error if :post is not present
      # allows listed attributes to be mass-assigned
      params.require(:post).permit(:title, :position, :visible, :content)
    end

end
