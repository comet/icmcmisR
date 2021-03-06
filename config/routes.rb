Icmcmis::Application.routes.draw do

  resources :nhifs

  resources :disbursednhifs

  resources :stockretakes

  resources :appointments

  resources :claim_particulars

  resources :settlements

  resources :families

  resources :payables
  resources :particulars

  get "search/index"

  get "search/search"

  get "search/results"
  get "reports/report_view"
  get "reports/patients"
  get "reports/encounters"
  get "reports/diagnoses"
  get "reports/custom"
  post "reports/custom"
  get "reports/treatments"
  get "reports/users"
  get "reports/payments"
  get "reports/csv"
  get "reports/nhif"
  post "reports/csv"
  get "appointments/index"
  
  get "appointments/show"
  get "appointments/destroy"

  get "dashboard/index"
  get "reports/index"
  get "payment/index"
  get "pharmacy/index"
  get "admin/index"

  get "sessions/index"

  get "sessions/login"
  get "sessions/logout"
  post "sessions/login"

  get "sessions/destroy"

  get "sessions/request_new"

  get "sessions/password"
  get "patients/quick_labs"
  post "patients/quick_labs"
  post "treatments/create"
  resources :payments do
    resources :particulars
  end
  resources :billing_plans
  resources :performedtests
  resources :special_observations
  resources :encounters
  resources :drugs
  resources :sales
  resources :treatments

  resources :tests

  resources :diagnoses

  resources :people
  resources :doctors
  resources :patients
  resources :users
  resources :patients do
    resources :appointments
    resources:special_observations
    resources :encounters
    resources :performedtests
    resources :treatments
    resources :diagnoses
    resources :payments

  end
  resources :encounters do
    resources :tests
    resources :treatments
    resources :diagnoses
    resources :performedtests
    resources :payments
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
  root :to => "sessions#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
