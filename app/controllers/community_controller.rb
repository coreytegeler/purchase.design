class CommunityController < ApplicationController

  layout_by_action [:admin] => "access", [:index] => "public"
  before_action :confirm_logged_in, :except => [:index, :admin]

  def index
    @events = Event.sorted
    @resources = Resource.sorted
  end

  def admin 
    @events = Event.sorted
    @resources = Resource.sorted
  end

end