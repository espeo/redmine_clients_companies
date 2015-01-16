resources :clients

resources :companies do
  member do
    get 'autocomplete_for_client'
    get 'autocomplete_for_user'
  end
end

match 'companies/:id/clients', :controller => 'companies', :action => 'add_clients', :id => /\d+/, :via => :post, :as => 'company_clients'
match 'companies/:id/clients/:client_id', :controller => 'companies', :action => 'remove_client', :id => /\d+/, :via => :delete, :as => 'company_client'

match 'companies/:id/users', :controller => 'companies', :action => 'add_users', :id => /\d+/, :via => :post, :as => 'company_users'
match 'companies/:id/users/:user_id', :controller => 'companies', :action => 'remove_user', :id => /\d+/, :via => :delete, :as => 'company_user'
