Rails.application.routes.draw do


  

  root to: 'toppages#index' #root_toの名前でtoppages/indexを実行

  get 'signup', to: 'users#new' #user/newアクションのURLの最後はsignup
  
  get 'login', to: 'sessions#new' #session/newアクションのURLの最後はlogin
  post 'login', to: 'sessions#create' #session/createアクションのURLの最後はlogin
  delete 'logout', to: 'sessions#destroy' #session/destroyアクションのURLの最後はlogout
  
  get 'request', to: 'managers#new' #manager/newアクションのURLの最後はrequest
  post 'request', to: 'managers#create' #manager/createアクションのURLの最後はrequest



  resources :users, only: [:create]
  #get⇒users/index,show,new,edit (4つ)post⇒users/create (1つ)patch⇒users/update(1つ) put⇒users/update(１つ) delete⇒users/destroy(1つ)
  
  resources :cabinets, except: [:show]  #, except: [:index]で除外可能
  #get⇒cabinets/index,show,new,edit (4つ)post⇒cabinets/create (1つ)patch⇒cabinets/update(1つ) put⇒cabinets/update(１つ) delete⇒cabinets/destroy(1つ)
end


