class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception

  before_filter :select_palette, only: [:index]
  before_filter :select_logo, only: [:index]
  before_filter :select_gradient, only: [:index]
  before_filter :select_pattern, only: [:index]
  before_filter :get_upload_icon, only: [:admin]
  before_filter :get_last_page, only: [:logout, :login]

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
    redirect_to(:controller => 'public', :action => 'index')
  end

  def clear_pattern
    session[:no_pattern] = true
    redirect_to(:controller => 'public', :action => 'index')
  end

  private

      def select_palette
        palettes = Palette.first_to_last
        if !params[:palette].nil?
          palette = palettes.where(:id => params[:palette]).first
          flash[:notice] = "This is Palette ##{palette.position}, do you want to try <a href='/palettes/admin'>another one</a>?"
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
        current_pos = session[:palette].last
        next_pos = next_check(current_pos, palettes)
        next_palette = palettes.where(:position => next_pos).first
        session[:next_palette] = [next_palette.primary_color, next_palette.secondary_color, next_palette.position]  
        redirect_to(:controller => 'public', :action => 'index')
      end

      def back_link(name)
        "This is #{name}, do you want to try <a href='/palettes/admin'>another one</a>?"
      end

      def select_logo
        logos = Logo.first_to_last
        if session[:logo].nil? || logos.where(:position => session[:logo]).first.nil?
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
        current_pos = session[:logo]
        next_pos = next_check(current_pos, Logo.all)
        session[:next_logo] = next_pos

        # @new_logo = Logo.where(:position => current_pos).first.file
        # @new_logo_svg = inline_svg(@new_logo, true).to_s.html_safe
        # @next_logo = Logo.where(:position => current_pos).first.file
        # @next_logo_svg = inline_svg(@next_logo, true).to_s.html_safe

        # respond_to do |format|
        #   format.js
        # end
        
        redirect_to(:controller => 'public', :action => 'index')
      end

      def select_gradient
        gradients = Gradient.first_to_last
        if session[:gradient].nil? || gradients.where(:position => session[:gradient]).first.nil?
          random = rand(1..gradients.length)
          gradient = gradients.where(:position => random).first
          session[:gradient] = gradient.position
        end

        current_gradient_pos = session[:gradient]

        if session[:no_gradient] == false
          @gradient = gradients.where(:position => current_gradient_pos).first.file
          @gradient_state = 'on'
        else
          @gradient = nil
          @gradient_state = 'off'
        end

        if session[:next_gradient].nil?
          find_next_gradient
        end

        @next_gradient = gradients.where(:position => session[:next_gradient]).first.file

      end

      def find_next_gradient
        gradients = Gradient.all
        current_pos = session[:gradient]
        next_pos = next_check(current_pos, gradients)
        session[:next_gradient] = next_pos
        redirect_to(:controller => 'public', :action => 'index')
      end

      def select_pattern
        patterns = Pattern.first_to_last
        if session[:pattern].nil? || patterns.where(:position => session[:pattern]).first.nil?
          random = rand(1..patterns.length)
          pattern = patterns.where(:position => random).first
          session[:pattern] = pattern.position
        end

        current_pattern_pos = session[:pattern]

        if session[:no_pattern] == false
          @pattern = patterns.where(:position => current_pattern_pos).first.image
          @pattern_state = 'on'
        else
          @pattern = nil
          @pattern_state = 'off'
        end

        if session[:next_pattern].nil?
          find_next_pattern
        end

        @next_pattern = patterns.where(:position => session[:next_pattern]).first.image
      end

      def find_next_pattern
        patterns = Pattern.all
        current_pos = session[:pattern]
        next_pos = next_check(current_pos, patterns)
        session[:next_pattern] = next_pos
        redirect_to(:controller => 'public', :action => 'index')
      end

      def next_check(i, q)
        if i != q.length
          i + 1
        else
          1
        end
      end

      def create_instance_vars
        @logo = Logo.where(:position => session[:logo]).first.file
        @next_logo = Logo.where(:position => session[:next_logo]).first.file
        @p = session[:palette].first
        @s = session[:palette].second
        @next_p = session[:next_palette].first
        @next_s = session[:next_palette].second
        @gradient = Gradient.where(:position => session[:gradient]).first.file
        @next_gradient = Gradient.where(:position => session[:next_gradient]).first.file
        @pattern = Pattern.where(:position => session[:pattern]).first.file
        @next_pattern = Pattern.where(:position => session[:next_pattern]).first.file
      end
         
end
