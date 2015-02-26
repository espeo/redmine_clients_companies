module EmployeesHelper
  def employee_settings_tabs
    tabs = [{:name => 'general', :partial => 'employees/general', :label => :label_general}]
    if Company.all.any?
      tabs.insert 1, {:name => 'companies', :partial => 'employees/companies', :label => :label_company_plural}
    end
    tabs
  end
end
