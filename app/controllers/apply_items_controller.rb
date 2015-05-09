class ApplyItemsController < ApplicationController

  layout_by_action "access", [:index] => "public"
  before_action :confirm_logged_in, :except => [:index, :admin]

  def index
    @apply_items = ApplyItem.sorted
  end

  def admin
    @apply_items = ApplyItem.sorted.reverse_order
    @show_to_options = ['parent', 'student']
    @new_apply_item = ApplyItem.new
    @new_apply_item.position = ApplyItem.count + 1
  end

  def create
    @apply_item = ApplyItem.new(apply_item_params)
    if @apply_item.save
      update_positions
      flash[:type] = 'good'
      flash[:notice] = "Application requirement was created!"
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Application requirement was not created!"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @new_apply_item = ApplyItem.new
      @new_apply_item.position = ApplyItem.count + 1
    end
  end

  def update
    @apply_item = ApplyItem.find(params[:id])
    if @apply_item.update_attributes(apply_item_params)
      update_positions
      flash[:type] = 'good'
      flash[:notice] = "Application requirement was updated!"
      redirect_to(:action => 'admin')
    else
      flash[:type] = 'bad'
      flash[:notice] = "Application requirement was not updated!"
      redirect_to(:action => 'admin')
      @new_apply_item = ApplyItem.new
      @new_apply_item.position = ApplyItem.count + 1
    end
  end

  def delete
    @apply_item = ApplyItem.find(params[:id])
    respond_to do |format|
      format.js { render partial: 'delete', :locals => {:apply_item => @apply_item} }
    end
  end

  def destroy
    @apply_item = ApplyItem.find(params[:id]).destroy
    update_positions
    flash[:type] = 'good'
    flash[:notice] = "Application requirement was deleted!"
    redirect_to(:action => 'admin')
  end

  private

    def apply_item_params
      params.require(:apply_item).permit(:student, :parent, :position)
    end

    def update_positions
      ApplyItem.sorted.each_with_index do |ai, i|
          ai.update_attribute(:position, i+1)
      end
    end

end
