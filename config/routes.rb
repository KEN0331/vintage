Rails.application.routes.draw do
  root to: "top#index"
  get "about_us" => "top#about_us"
  get "show_item" => "top#show_item"
  get "categorized" => "top#categorized"  
  get "get_image1" => "top#get_image1"
  get "get_image2" => "top#get_image2"
  get "get_image3" => "top#get_image3"
  get "get_image4" => "top#get_image4"
  get "new_arrivals" => "top#new_arrivals"
  get "recommend" => "top#recommend"
  get "blog" => "top#blog"
  get "contact" => "top#contact"
  get "search" => "top#search"
  get "cart" => "top#add"
  get "delete_cart_item" => "top#delete_cart_item"
  get 'thanks' => 'top#thanks'
  post "plural_delete_cart_item" => "top#plural_delete_cart_item"


  
  
  get 'pay' => 'webpay#pay'


  namespace :admin do
    root to: "top#index"
    
    resource :session, only: [:create, :destroy]
    
    get "items/change_subcategories"
    get "items/subcategory"
    get "items/units"
    post "items/plural_destroy"
    post "categories/plural_destroy"
    post "subcategories/plural_destroy"
    post "denominations/plural_destroy"
    post "conditions/plural_destroy"
    post "fabrics/plural_destroy"
    post "units/plural_destroy"
    post "item_types/plural_destroy"
    post "new_arrivals/plural_destroy"
    post "recommendations/plural_destroy"
    post "authorities/plural_destroy"
    post "administrators/plural_destroy"
    
    
    resources :items do
      collection {get "search"}
    end
    
    resources :categories do
      collection {get "search"}
    end
    
    resources :subcategories do
      collection {get "search"}
    end
    
    resources :denominations do
      collection {get "search"}
    end
    
    resources :conditions do
      collection {get "search"}
    end
    
    resources :fabrics do
      collection {get "search"}
    end
    
    resources :units do
      collection {get "search"}
    end
    
    resources :item_types do
      collection {get "search"}
    end
    
    resources :new_arrivals do
      collection {get "search"}
    end
    
    resources :recommendations do
      collection {get "search"}
    end
    
    resources :authorities do
      collection {get "search"}
    end
    
    resources :administrators do
      collection {get "search"}
    end
    
    get "get_image1" => "items#get_image1"
    get "get_image2" => "items#get_image2"
    get "get_image3" => "items#get_image3"
    get "get_image4" => "items#get_image4"
    get "get_image" => "recommendations#get_image"
    
  end

  
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
