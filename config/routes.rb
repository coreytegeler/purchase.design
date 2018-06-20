Rails.application.routes.draw do

  get 'model/resources'

  root "works#index"
  
  get 'admin', :to => 'access#login'
  get 'cms', :to => 'access#login'
  get 'backend', :to => 'access#login'
  get 'access', :to => 'access#login'
  get 'login', :to => 'access#login'

  get 'admins', :to => 'admins#admin'
  get 'gradients', :to => 'gradients#admin'
  get 'logos', :to => 'logos#admin'
  get 'palettes', :to => 'palettes#admin'
  get 'patterns', :to => 'patterns#admin'

  get 'backend/abouts', :to => 'abouts#admin'
  get 'backend/admins', :to => 'admins#admin'
  get 'backend/alumni', :to => 'alumni#admin'
  get 'backend/apply_items', :to => 'apply_items#admin'
  get 'backend/courses', :to => 'courses#admin'
  get 'backend/faculties', :to => 'faculties#admin'
  get 'backend/gradients', :to => 'gradients#admin'
  get 'backend/logos', :to => 'logos#admin'
  get 'backend/palettes', :to => 'palettes#admin'
  get 'backend/patterns', :to => 'patterns#admin'
  get 'backend/posts', :to => 'posts#admin'
  get 'backend/resources', :to => 'resources#admin'
  get 'backend/works', :to => 'works#admin'

  get 'faculty', :to => 'faculties#index'
  get 'faculty/:action', :to => 'faculties#action'
  post 'faculty/:action', :to => 'faculties#action'

  get 'about/:action', :to => 'abouts#action'
  post 'about/:action', :to => 'abouts#action'

  get 'apply', :to => 'apply_items#index'
  get 'apply/:action', :to => 'apply_items#action'
  post 'apply/:action', :to => 'apply_items#action'

  get 'course/:id', :to => 'courses#single'

  get 'work', :to => 'works#index'
  get 'work/:action', :to => 'works#action'
  post 'work/:action', :to => 'works#action'

  get 'news', :to => 'posts#index'
  get 'news/:action', :to => 'posts#action'
  post 'news/:action', :to => 'posts#action'

  post "next_palette", :to => "application#next_palette"
  post "next_logo", :to => "application#next_logo"
  post "next_gradient", :to => "application#next_gradient"
  post "next_pattern", :to => "application#next_pattern"
  post "clear_gradient", :to => "application#clear_gradient"
  post "clear_pattern", :to => "application#clear_pattern"
  post "change_page", :to => "application#change_page"

  match ':controller(/:action(/:id))', :via => [:get, :post]

end
