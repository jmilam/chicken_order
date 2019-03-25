Rails.application.routes.draw do
  get 'farm/index'

  get 'farm/:unique_key', to: 'farm#edit', as: 'edit_farm'
  patch 'farm/update'

  get 'order/index'
  get 'order/show'
  get 'order/list'
  get 'order/details/:id', to: 'order#details', as: 'order_details'
  get 'order/farm_order_availability'
  post 'order/create'
  patch 'order/filled'
  patch 'order/delivered'
  patch 'order/cancel_order/:id', to: 'order#cancel_order', as: 'cancel_order'

  root to: 'order#index'
  # mount ActionCable.server, at: '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
