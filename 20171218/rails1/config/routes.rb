Rails.application.routes.draw do
  get 'home/squre'

  #root페이지(localhost:3000)으로 들어오면
  #home 컨트롤러의 index 액션을 보여줄게
  root "home#index"            #index대신에 lotto 해도됨

  get '/index'   =>  "home#index"

#http://localhost:3000/lotto 요청이 들어오면
#home 컨트롤러의 lotto액션에 보내줘


  get '/lotto'  =>  "home#lotto"

  get '/welcome' => "home#welcome"

  get '/welcome/:name'  =>  "home#welcome"

  get '/squre/:num'  => "home#squre"

  get '/lunch' => 'home#lunch'
  get '/marogle' => 'home#marogle'
  get '/marover' => 'home#marover'
  get '/vote' => 'home#vote'
  get '/result' => 'home#result'
  get '/random1' => 'home#random1'
  get '/resultrand' =>'home#resultrand'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
