Rails.application.routes.draw do

 namespace :admin do #admin/～を加える
  get 'signup', to: 'users#new' #user/newアクションのURLの最後はsignup

  resources :users, only: [:create]
  #get⇒users/index,show,new,edit (4つ)post⇒users/create (1つ)patch⇒users/update(1つ) put⇒users/update(１つ) delete⇒users/destroy(1つ)
 end  

  post 'cabinets', to: 'cabinets#create' #5.24追加
  post 'requests', to: 'requests#create' #5.24追加
  resources :requests #5.9追加 5.19変更

  root to: 'sessions#new' #root_to=最初の"/"でリンクする先を指定。
  
  get 'login', to: 'sessions#new' #session/newアクションのURLの最後はlogin
  post 'login', to: 'sessions#create' #session/createアクションのURLの最後はlogin
  delete 'logout', to: 'sessions#destroy' #session/destroyアクションのURLの最後はlogout
  

  delete :cabinets, to: 'cabinets#destroy_all' #5.6追加　一括削除
  patch 'update_delete', to: 'cabinets#update_delete' #6.6追加
  patch 'update_accept', to: 'cabinets#update_accept' #6.7追加
  
  resources :cabinets  #, except: [:index]で除外可能
  #get⇒cabinets/index,show,new,edit (4つ)post⇒cabinets/create (1つ)patch⇒cabinets/update(1つ) put⇒cabinets/update(１つ) delete⇒cabinets/destroy(1つ)
end


