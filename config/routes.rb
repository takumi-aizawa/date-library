Rails.application.routes.draw do


  

  root to: 'toppages#index' #root_toの名前でtoppages/indexを実行

  get 'signup', to: 'users#new' #user/newアクションのURLの最後はsignup
  
  get 'login', to: 'sessions#new' #session/newアクションのURLの最後はlogin
  post 'login', to: 'sessions#create' #session/createアクションのURLの最後はlogin
  delete 'logout', to: 'sessions#destroy' #session/destroyアクションのURLの最後はlogout

  resources :users, only: [:new, :create]
  #get⇒users/index,show,new,edit (4つ)post⇒users/create (1つ)patch⇒users/update(1つ) put⇒users/update(１つ) delete⇒users/destroy(1つ)
  
  resources :sessions, only: [:new, :create, :destroy]
  
  resources :cabinets, except: [:show]  #, except: [:index]で除外可能
  #get⇒cabinets/index,show,new,edit (4つ)post⇒cabinets/create (1つ)patch⇒cabinets/update(1つ) put⇒cabinets/update(１つ) delete⇒cabinets/destroy(1つ)
end


#Rails.application.routes.draw do
#  root to: 'toppages#index'

#  get 'signup', to: 'users#new'   →user/newのURLの最後はsignup
#  resources :users, only: [:index, :show, :new, :create]
#end