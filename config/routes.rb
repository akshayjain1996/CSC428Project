Rails.application.routes.draw do
  resources :photos
  get '/classify', to: 'classify#index', as: 'index'
  get '/re_classify/:image_id', to: 'classify#re_classify', as: 're_classify'
  post '/classify_image', to: 'classify#classify_post', as: 'classify_post'
  get '/summary', to: 'classify#summary', as: 'summary'
  get '/download/0', to: 'download#c0', as: 'c0'
  get '/download/1', to: 'download#c1', as: 'c1'
  get '/download/2', to: 'download#c2', as: 'c2'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
