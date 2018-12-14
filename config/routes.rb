Rails.application.routes.draw do
  get 'users/login'
  get 'projects/index'
  get 'projects/add'
  get 'projects/list'
  get 'projects/delete/:projectid' => "projects#delete"
  get 'projects/edit/:projectid' => "projects#change"  
  post 'users/login' => 'users#logincheck'
  post 'projects/add' => 'projects#addcheck'
  post 'projects/change' => 'projects#editcheck'
  post 'projects/edit/:projectid' => "projects#editcheck"  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
