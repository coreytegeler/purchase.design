class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception

  before_action :select_palette, only: [:index]
  before_action :select_logo, only: [:index]
  before_action :select_gradient, only: [:index]
  before_action :select_pattern, only: [:index]
  before_action :get_upload_icon, only: [:admin]
  before_action :get_last_page, only: [:logout, :login]

  def logged_in?
  	!!session[:admin_id]
  end

  def confirm_logged_in
    get_last_page
    unless session[:admin_id]
      flash[:type] = "bad"
      flash[:notice] = "Did you think we'd let you do that without logging in first?"
      redirect_to(:controller => 'access', :action => 'login')
      return false
    else
      return true
    end
  end

  def get_last_page
    session[:last_page] ||= request.referer
  end

  def go_back
    if !session[:last_page].nil?
      redirect_to session.delete(:last_page)
    end
  end

  def get_upload_icon
    @upload_img = view_context.image_path('upload.svg')
  end

  def next_palette
    session[:palette] = session[:next_palette]
    find_next_palette
  end

  def next_logo
    session[:logo] = session[:next_logo]
    find_next_logo
  end

  def next_gradient
    session[:no_gradient] = false
    session[:gradient] = session[:next_gradient]
    find_next_gradient
  end

  def next_pattern
    session[:no_pattern] = false
    session[:pattern] = session[:next_pattern]
    find_next_pattern
  end

  def clear_gradient
    session[:no_gradient] = true
    respond_to do |format|
      format.js { render partial: 'clear_gradient' }
    end
  end

  def clear_pattern
    session[:no_pattern] = true
    respond_to do |format|
      format.js { render partial: 'clear_pattern' }
    end
  end

  private

      def select_palette
        palettes = Palette.first_to_last
        if !params[:palette].nil?
          palette = palettes.where(:id => params[:palette]).first
          flash[:notice] = "This is palette ##{palette.position}. <a href='/backend/palettes'>Go back?</a>"
          flash[:type] = 'neutral'
          session[:palette] = [palette.primary_color, palette.secondary_color, palette.position]
        elsif session[:palette].nil?
          random = rand(1..palettes.length)
          palette = palettes.where(:position => random).first
          session[:palette] = [palette.primary_color, palette.secondary_color, palette.position]
        end
        current_palette = session[:palette]
        @p = current_palette.first
        @s = current_palette.second
        if session[:next_palette].nil?
          find_next_palette
        end
        @next_p = session[:next_palette].first
        @next_s = session[:next_palette].second
      end

      def find_next_palette
        palettes = Palette.all
        current_palette = session[:palette]
        current_palette_pos = current_palette.last
        next_palette_pos = next_check(current_palette_pos, palettes)
        next_palette = palettes.where(:position => next_palette_pos).first
        session[:next_palette] = [next_palette.primary_color, next_palette.secondary_color, next_palette.position]

        respond_to do |format|
          format.js { render partial: 'update_palette',
            :locals => {
              :new_primary => current_palette.first,
              :new_secondary => current_palette.second,
              :next_primary => next_palette.primary_color,
              :next_secondary => next_palette.secondary_color
            }
          }
          format.html { redirect_to '/' }
        end
      end

      def update_palette 
        
      end

      def select_logo
        logos = Logo.first_to_last
        if !params[:logo].nil?
          logo = logos.where(:id => params[:logo]).first
          flash[:notice] = "This is logo ##{logo.position}. <a href='/backend/logos'>Go back?</a>"
          flash[:type] = 'neutral'
          session[:logo] = [logo.position]
        elsif session[:logo].nil? || logos.where(:position => session[:logo]).first.nil?
          random = rand(1..logos.length)
          logo = logos.where(:position => random).first
          session[:logo] = logo.position
        end
        current_logo_pos = session[:logo]
        @logo = logos.where(:position => current_logo_pos).first.file
        if session[:next_logo].nil?
          find_next_logo
        end
        @next_logo = logos.where(:position => session[:next_logo]).first.file
      end

      def find_next_logo
        current_logo_pos = session[:logo]
        next_logo_pos = next_check(current_logo_pos, Logo.all)
        session[:next_logo] = next_logo_pos
        new_logo = Logo.where(:position => current_logo_pos).first.file
        next_logo = Logo.where(:position => next_logo_pos).first.file
        respond_to do |format|
          format.js { render partial: 'next_logo', :locals => {:new_logo => new_logo, :next_logo => next_logo} }
          format.html { redirect_to '/' }
        end
      end

      def select_gradient
        gradients = Gradient.first_to_last
        if !params[:gradient].nil?
          gradient = gradients.where(:id => params[:gradient]).first
          flash[:notice] = "This is gradient ##{gradient.position}. <a href='/backend/gradients'>Go back?</a>"
          flash[:type] = 'neutral'
          session[:gradient] = gradient.position
          session[:no_gradient] = false
          find_next_gradient
        elsif session[:gradient].nil? || gradients.where(:position => session[:gradient]).first.nil?
          random = rand(1..gradients.length)
          gradient = gradients.where(:position => random).first
          session[:gradient] = gradient.position
        end

        current_gradient_pos = session[:gradient]

        if session[:no_gradient] == false
          @gradient = gradients.where(:position => current_gradient_pos).first.file
          @gradient_state = 'gradient_on'
        else
          @gradient = nil
          @gradient_state = ''
        end

        if session[:next_gradient].nil?
          find_next_gradient
        end

        @next_gradient = gradients.where(:position => session[:next_gradient]).first.file
      end

      def find_next_gradient
        gradients = Gradient.all
        current_gradient_pos = session[:gradient]
        next_gradient_pos = next_check(current_gradient_pos, gradients)
        session[:next_gradient] = next_gradient_pos
        new_gradient = gradients.where(:position => current_gradient_pos).first.file
        next_gradient = gradients.where(:position => next_gradient_pos).first.file
        respond_to do |format|
          format.js { render partial: 'next_gradient', :locals => {:new_gradient => new_gradient, :next_gradient => next_gradient} }
          format.html { redirect_to '/' }
        end
      end

      def select_pattern
        patterns = Pattern.first_to_last
        if !params[:pattern].nil?
          pattern = patterns.where(:id => params[:pattern]).first
          flash[:notice] = "This is pattern ##{pattern.position}. <a href='/backend/patterns'>Go back?</a>"
          flash[:type] = 'neutral'
          session[:pattern] = pattern.position
          session[:no_pattern] = false
          find_next_pattern
        elsif session[:pattern].nil? || patterns.where(:position => session[:pattern]).first.nil?
          random = rand(1..patterns.length)
          pattern = patterns.where(:position => random).first
          session[:pattern] = pattern.position
        end

        current_pattern_pos = session[:pattern]

        if session[:no_pattern] == false
          @pattern = patterns.where(:position => current_pattern_pos).first.tile
          @pattern_state = 'pattern_on'
        else
          @pattern = nil
          @pattern_state = ''
        end

        if session[:next_pattern].nil?
          find_next_pattern
        end

        @next_pattern = patterns.where(:position => session[:next_pattern]).first.tile
      end

      def find_next_pattern
        patterns = Pattern.all
        current_pattern_pos = session[:pattern]
        next_pattern_pos = next_check(current_pattern_pos, patterns)
        session[:next_pattern] = next_pattern_pos
        new_pattern = patterns.where(:position => current_pattern_pos).first.tile
        next_pattern = patterns.where(:position => next_pattern_pos).first.tile
        respond_to do |format|
          format.js { render partial: 'next_pattern', :locals => {:new_pattern => new_pattern, :next_pattern => next_pattern} }
          format.html { redirect_to '/' }
        end
      end

      def next_check(i, q)
        if i == q.length
          1
        else
          i + 1
        end
      end
end
