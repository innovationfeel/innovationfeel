Rails.application.routes.draw do
  devise_for :users, path: 'admin', path_names: { sign_in: 'login', sign_out: 'logout' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  post '/contact_us' => 'home#contact_us', as: :contact_us
  get '/blog' => 'blog#index', as: :blog
  get '/blog(/:post_slug)' => 'blog#show', as: :blog_show

  namespace :admin do
    resources :posts, param: :post_slug
  end
  get '/admin' => 'admin/home#index', as: :admin
end
