module EspeoEmployeesCompanies
  class Hooks < Redmine::Hook::ViewListener

    # Show user's groups & companies in users#show view.
    #
    # Available context variables:
    # :user => User
    def view_account_left_bottom(context = {})
      context[:controller].send(:render_to_string, {
        :partial => "users/show_companies_and_groups",
        :locals => context
      })
    end

  end
end
