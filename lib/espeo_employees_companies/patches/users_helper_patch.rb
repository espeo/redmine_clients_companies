require_dependency 'users_helper'

module EspeoEmployeesCompanies::Patches::UsersHelperPatch
  def self.included(base)
    base.send :include, InstanceMethods

    base.class_eval do
      alias_method_chain :user_settings_tabs, :companies_tab
    end
  end

  module InstanceMethods
    def user_settings_tabs_with_companies_tab
      tabs = user_settings_tabs_without_companies_tab

      if Company.all.any?
        tabs.insert 1, {:name => 'companies', :partial => 'users/companies', :label => :label_company_plural}
      end

      tabs
    end
  end
end

Rails.application.config.to_prepare do
  UsersHelper.send :include, EspeoEmployeesCompanies::Patches::UsersHelperPatch
end
