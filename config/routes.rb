MercatorBechlem::Engine.routes.draw do
  resources :consumables, :only => [:index] do
    member do
      get 'products'
      get 'printers'
      get 'category'
    end
  end
end
