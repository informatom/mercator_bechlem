MercatorBechlem::Engine.routes.draw do
  get 'products/:printer' => 'consumables#products', :as => 'consumables_products'
  get 'printer/:printerseries' => 'consumables#printer', :as => 'consumables_printer'
  get 'category/:category_id' => 'consumables#category', :as => 'consumables_category'
end
