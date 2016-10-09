Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  post '/contact_us' => 'home#contact_us', as: :contact_us
  get '/blog' => 'blog#index', as: :blog
  get '/blog(/:post_slug)' => 'blog#show', as: :blog_show
  resources :posts
end
