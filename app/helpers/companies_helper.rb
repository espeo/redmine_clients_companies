module CompaniesHelper
  def company_settings_tabs
    tabs = [{:name => 'general', :partial => 'companies/general', :label => :label_general},
            {:name => 'employees', :partial => 'companies/employees', :label => :label_employee_plural},
            {:name => 'users', :partial => 'companies/users', :label => :label_user_plural},
            ]
  end

  def render_principals_for_new_company_employees(company)
    scope = Employee.active.sorted.not_in_company(company).like(params[:q])
    principal_count = scope.count
    principal_pages = Redmine::Pagination::Paginator.new principal_count, 100, params['page']
    principals = scope.offset(principal_pages.offset).limit(principal_pages.per_page).all

    s = content_tag('div', principals_check_box_tags('employee_ids[]', principals), :id => 'principals')

    links = pagination_links_full(principal_pages, principal_count, :per_page_links => false) {|text, parameters, options|
      link_to text, autocomplete_for_employee_company_path(company, parameters.merge(:q => params[:q], :format => 'js')), :remote => true
    }

    s + content_tag('p', links, :class => 'pagination')
  end

  def render_principals_for_new_company_users(company)
    scope = User.active.sorted.not_in_company(company).like(params[:q])
    principal_count = scope.count
    principal_pages = Redmine::Pagination::Paginator.new principal_count, 100, params['page']
    principals = scope.offset(principal_pages.offset).limit(principal_pages.per_page).all

    s = content_tag('div', principals_check_box_tags('user_ids[]', principals), :id => 'principals')

    links = pagination_links_full(principal_pages, principal_count, :per_page_links => false) {|text, parameters, options|
      link_to text, autocomplete_for_user_company_path(company, parameters.merge(:q => params[:q], :format => 'js')), :remote => true
    }

    s + content_tag('p', links, :class => 'pagination')
  end
end
