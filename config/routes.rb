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

	get 'about', :to => 'abouts#index'
	get 'about/:admin', :to => 'abouts#admin'
	post 'about/:create', :to => 'abouts#create'
	post 'about/:update', :to => 'abouts#update'
	post 'about/:delete', :to => 'abouts#delete'
	post 'about/:destroy', :to => 'abouts#destroy'

	get 'admin', :to => 'admins#index'
	get 'admin/:admin', :to => 'admins#admin'
	post 'admin/:create', :to => 'admins#create'
	post 'admin/:update', :to => 'admins#update'
	post 'admin/:delete', :to => 'admins#delete'
	post 'admin/:destroy', :to => 'admins#destroy'

	get 'alumni', :to => 'alumni#index'
	get 'alumni/:admin', :to => 'alumni#admin'
	post 'alumni/:create', :to => 'alumni#create'
	post 'alumni/:update', :to => 'alumni#update'
	post 'alumni/:delete', :to => 'alumni#delete'
	post 'alumni/:destroy', :to => 'alumni#destroy'

	get 'apply', :to => 'apply_items#index'
	get 'apply/:admin', :to => 'apply_items#admin'
	post 'apply/:create', :to => 'apply_items#create'
	post 'apply/:update', :to => 'apply_items#update'
	post 'apply/:delete', :to => 'apply_items#delete'
	post 'apply/:destroy', :to => 'apply_items#destroy'
	
	get 'course', :to => 'courses#index'
	get 'course/:admin', :to => 'courses#admin'
	get 'course/single/:id', :to => 'courses#single'
	post 'course/:create', :to => 'courses#create'
	post 'course/:update', :to => 'courses#update'
	post 'course/:delete', :to => 'courses#delete'
	post 'course/:destroy', :to => 'courses#destroy'

	get 'faculty', :to => 'faculties#index'
	get 'faculty/:admin', :to => 'faculties#admin'
	post 'faculty/:create', :to => 'faculties#create'
	post 'faculty/:update', :to => 'faculties#update'
	post 'faculty/:delete', :to => 'faculties#delete'
	post 'faculty/:destroy', :to => 'faculties#destroy'

	get 'gradient', :to => 'gradients#index'
	get 'gradient/:admin', :to => 'gradients#admin'
	post 'gradient/:create', :to => 'gradients#create'
	post 'gradient/:update', :to => 'gradients#update'
	post 'gradient/:delete', :to => 'gradients#delete'
	post 'gradient/:destroy', :to => 'gradients#destroy'

	get 'logo', :to => 'logos#admin'
	get 'logo/:admin', :to => 'logos#admin'
	post 'logo/:create', :to => 'logos#create'
	post 'logo/:update', :to => 'logos#update'
	post 'logo/:delete', :to => 'logos#delete'
	post 'logo/:destroy', :to => 'logos#destroy'

	get 'palette', :to => 'palettes#admin'
	get 'palette/:admin', :to => 'palettes#admin'
	post 'palette/:create', :to => 'palettes#create'
	post 'palette/:update', :to => 'palettes#update'
	post 'palette/:delete', :to => 'palettes#delete'
	post 'palette/:destroy', :to => 'palettes#destroy'

	get 'pattern', :to => 'patterns#admin'
	get 'pattern/:admin', :to => 'patterns#admin'
	post 'pattern/:create', :to => 'patterns#create'
	post 'pattern/:update', :to => 'patterns#update'
	post 'pattern/:delete', :to => 'patterns#delete'
	post 'pattern/:destroy', :to => 'patterns#destroy'

	get 'work', :to => 'works#index'
	get 'work/:admin', :to => 'works#admin'
	post 'work/:create', :to => 'works#create'
	post 'work/:update', :to => 'works#update'
	post 'work/:delete', :to => 'works#delete'
	post 'work/:destroy', :to => 'works#destroy'

	get 'news', :to => 'posts#index'
	get 'news/:admin', :to => 'posts#admin'
	post 'news/:create', :to => 'posts#create'
	post 'news/:update', :to => 'posts#update'
	post 'news/:delete', :to => 'posts#delete'
	post 'news/:destroy', :to => 'posts#destroy'

	get 'resource', :to => 'resources#index'
	get 'resource/:admin', :to => 'resources#admin'
	post 'resource/:create', :to => 'resources#create'
	post 'resource/:update', :to => 'resources#update'
	post 'resource/:delete', :to => 'resources#delete'
	post 'resource/:destroy', :to => 'resources#destroy'

	post "next_palette", :to => "application#next_palette"
	post "next_logo", :to => "application#next_logo"
	post "next_gradient", :to => "application#next_gradient"
	post "next_pattern", :to => "application#next_pattern"
	post "clear_gradient", :to => "application#clear_gradient"
	post "clear_pattern", :to => "application#clear_pattern"
	post "change_page", :to => "application#change_page"

	match ':controller(/:action(/:id))', :via => [:get, :post]

end
