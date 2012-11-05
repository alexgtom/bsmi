Bsmi::Application.routes.draw do
  resources :invites

  resources :courses

  resources :cal_courses

  resources :districts

  resources :schools

  resources :user_sessions


  resources :invites

  match 'login' => "user_sessions#new",      :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout

  resources :users  # give us our some normal resource routes for users
  resource :user, :as => 'account'  # a convenience route

  match '/user/adv_new' => 'users#adv_new', :as => 'advisor_new_user'
  match '/user/adv_create' => 'users#adv_create', :as => 'advisor_create_user'
  match '/user/:id/adv_edit' => 'users#adv_edit', :as => 'advisor_edit_user'
  match '/user/adv_edit' => 'users#adv_update', :as => 'advisor_update_user'

  match '/send_invitation/:id' => 'invites#send_invitation', :as => 'send_invitation'
  match '/signup/:invite_code' => 'users#new', :as => 'redeem_invitation'

  match 'signup' => 'users#new', :as => :signup


  resources :mentor_teachers
  namespace :mentor_teacher do
    resource :schedule      
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'schools#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  resources :advisors

  resources :students do
    resources :select_timeslots
    member do 
      get 'placements'
      get 'timeslot_selection'
      post 'timeslot_selection'
    end
  end
  resources :timeslots
  resources :settings
end
