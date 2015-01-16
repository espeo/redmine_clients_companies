module EspeoClientsCompanies::Models::UserPatch
  def self.included(base)
    base.extend         ClassMethods
    base.send :include, InstanceMethods

    base.class_eval do
      has_and_belongs_to_many :companies,
                              :join_table   => "#{table_name_prefix}companies_users#{table_name_suffix}"
    end
  end

  module ClassMethods
  end

  module InstanceMethods
  end
end

Rails.application.config.to_prepare do
  User.send :include, EspeoClientsCompanies::Models::UserPatch
end
