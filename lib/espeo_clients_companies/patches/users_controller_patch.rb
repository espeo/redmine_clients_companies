module EspeoClientsCompanies::Patches::UsersControllerPatch
  def self.included(base)
    base.extend         ClassMethods
    base.send :include, InstanceMethods

    base.class_eval do
      before_filter :only => :index do
        params[:group_id] = params[:company_id] if params[:company_id].present?
        @companies = Company.all.sort
      end
    end
  end

  module ClassMethods
  end

  module InstanceMethods
  end
end

Rails.application.config.to_prepare do
  UsersController.send :include, EspeoClientsCompanies::Patches::UsersControllerPatch
end
