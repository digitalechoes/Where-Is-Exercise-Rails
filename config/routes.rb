Rails.application.routes.draw do
  root 'main#index'
  post '/' => 'main#index'
  post 'sms_incoming' => 'main#incoming'

  # I'd usually stick to excepts
  resources :conference_rooms, only: [:index]
end
