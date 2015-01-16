require 'espeo_clients_companies/patches/user_patch'
require 'espeo_clients_companies/patches/users_controller_patch'
require 'espeo_clients_companies/patches/users_helper_patch'
require 'espeo_clients_companies/hooks'

Redmine::Plugin.register :espeo_clients_companies do
  name 'Clients & Companies plugin'
  author 'espeo@jtom.me'
  description "Adds Client & Company models and its' CRUD controllers."
  version '1.0.0'
  url 'http://espeo.pl'
  author_url 'http://jtom.me'

  menu :admin_menu, :clients, {:controller => 'clients'},
    :caption => :label_client_plural,
    :after => :users,
    :html => { :class => "users" }
  menu :admin_menu, :companies, {:controller => 'companies'},
    :caption => :label_company_plural,
    :after => :groups,
    :html => { :class => "groups" }
end

Rails.application.config.to_prepare do
  CustomFieldsHelper::CUSTOM_FIELDS_TABS << {
    :name => 'ClientCustomField',
    :partial => 'custom_fields/index',
    :label => :label_client_plural
  }

  CustomFieldsHelper::CUSTOM_FIELDS_TABS << {
    :name => 'CompanyCustomField',
    :partial => 'custom_fields/index',
    :label => :label_company_plural
  }
end
