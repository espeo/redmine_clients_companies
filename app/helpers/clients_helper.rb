module ClientsHelper
  def client_settings_tabs
    tabs = [{:name => 'general', :partial => 'clients/general', :label => :label_general}]
    if Company.all.any?
      tabs.insert 1, {:name => 'companies', :partial => 'clients/companies', :label => :label_company_plural}
    end
    tabs
  end
end
