resources :employees

resources :companies do
  member do
    get 'autocomplete_for_employee'
    get 'autocomplete_for_user'
  end
end

match 'companies/:id/employees', :controller => 'companies', :action => 'add_employees', :id => /\d+/, :via => :post, :as => 'company_employees'
match 'companies/:id/employees/:employee_id', :controller => 'companies', :action => 'remove_employee', :id => /\d+/, :via => :delete, :as => 'company_employee'

match 'companies/:id/users', :controller => 'companies', :action => 'add_users', :id => /\d+/, :via => :post, :as => 'company_users'
match 'companies/:id/users/:user_id', :controller => 'companies', :action => 'remove_user', :id => /\d+/, :via => :delete, :as => 'company_user'
