Bsmi::Application.routes.draw do
  resources :deadlines

  resources :semesters

  resources :courses

  resources :cal_courses

  resources :districts

  resources :schools

  resources :user_sessions

  resources :settings

  resources :matchings

  match '/invites/new_excel' => 'invites#new_excel', :as => 'new_invite_excel'
  match '/invites/uploadFile_and_invite' => 'invites#uploadFile_and_invite', :as => 'uploadFile_and_invite'
  resources :invites


  match 'login' => "user_sessions#new",      :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout

  resources :users  # give us our some normal resource routes for users
  resource :user, :as => 'account'  # a convenience route

  match '/user/adv_new' => 'users#adv_new', :as => 'advisor_new_user'
  match '/user/adv_create' => 'users#adv_create', :as => 'advisor_create_user'
  match '/user/:id/adv_show' => 'users#adv_show', :as => 'advisor_show_user'
  match '/user/:id/adv_edit' => 'users#adv_edit', :as => 'advisor_edit_user'
  match '/user/adv_edit' => 'users#adv_update', :as => 'advisor_update_user'

  match '/user/:id/cf_show' => 'users#cf_show', :as => 'cal_faculty_show_user'

  match '/send_invitation/:id' => 'invites#send_invitation', :as => 'send_invitation'
  match '/signup/:invite_code' => 'users#new', :as => 'redeem_invitation'

  match 'signup' => 'users#new', :as => :signup


  resources :mentor_teachers
  namespace :mentor_teacher do
    resources :my_students  
    resource :schedule    
  end

  namespace :cal_faculty do
    resources :my_students     
    resources :my_mentor_teachers
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
    resources :select_cal_courses
    resources :select_timeslots, :path => 'semesters/:semester_id/courses/:cal_course_id/select_timeslots'
    member do 
      get 'splash'
      get 'placements', :path => 'semesters/:semester_id/placements'
      get 'edit_placements', :path => 'semesters/:semester_id/edit_placements'
      put 'edit_placements', :path => 'semesters/:semester_id/edit_placements'
      post 'edit_placements', :path => 'semesters/:semester_id/edit_placements'
      delete 'edit_placements', :path => 'semesters/:semester_id/edit_placements'
      get 'select_courses', :path => 'semesters/:semester_id/select_courses'
      put 'select_courses', :path => 'semesters/:semester_id/select_courses'
      get 'courses', :as => 'courses', :path => 'semesters/:semester_id/courses'
    end
  end
  match '/timeslots/destroy', :controller => :timeslots, :action => :destroy
  resources :timeslots
end
