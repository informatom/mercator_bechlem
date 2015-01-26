Mercator::Application.routes.draw do
  get 'consumables/:id/products/' => "consumables#products", :as => 'products_consumables'
  post 'consumables/products/' => "consumables#products"
  get 'consumables/:id/printers/' => "consumables#printers", :as => 'printers_consumables'

  get 'consumables/:id/category/' => "consumables#category", :as => 'category_consumables'
end