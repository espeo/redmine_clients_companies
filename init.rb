require 'espeo_employees_companies/patches/user_patch'
require 'espeo_employees_companies/patches/users_controller_patch'
require 'espeo_employees_companies/patches/users_helper_patch'
require 'espeo_employees_companies/hooks'

Redmine::Plugin.register :espeo_employees_companies do
  name 'Employees & Companies plugin'
  author 'espeo@jtom.me'
  description "Adds Employee & Company models and its' CRUD controllers."
  version '1.0.0'
  url 'http://espeo.pl'
  author_url 'http://jtom.me'

  menu :admin_menu, :employees, {:controller => 'employees'},
    :caption => :label_employee_plural,
    :after => :users,
    :html => { :class => "users" }
  menu :admin_menu, :companies, {:controller => 'companies'},
    :caption => :label_company_plural,
    :after => :groups,
    :html => { :class => "groups" }
end

Rails.application.config.to_prepare do
  CustomFieldsHelper::CUSTOM_FIELDS_TABS << {
    :name => 'EmployeeCustomField',
    :partial => 'custom_fields/index',
    :label => :label_employee_plural
  }

  CustomFieldsHelper::CUSTOM_FIELDS_TABS << {
    :name => 'CompanyCustomField',
    :partial => 'custom_fields/index',
    :label => :label_company_plural
  }
end
