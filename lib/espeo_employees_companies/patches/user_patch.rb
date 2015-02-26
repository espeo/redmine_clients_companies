module EspeoEmployeesCompanies::Patches::UserPatch
  def self.included(base)
    base.extend         ClassMethods
    base.send :include, InstanceMethods

    base.class_eval do
      has_and_belongs_to_many :companies,
                              :join_table   => "#{table_name_prefix}groups_users#{table_name_suffix}",
                              :association_foreign_key => :group_id

      scope :in_company, lambda {|company|
        company_id = company.is_a?(Company) ? company.id : company.to_i
        where("#{User.table_name}.id IN (SELECT gu.user_id FROM #{table_name_prefix}groups_users#{table_name_suffix} gu WHERE gu.group_id = ?)", company_id)
      }
      scope :not_in_company, lambda {|company|
        company_id = company.is_a?(Company) ? company.id : company.to_i
        where("#{User.table_name}.id NOT IN (SELECT gu.user_id FROM #{table_name_prefix}groups_users#{table_name_suffix} gu WHERE gu.group_id = ?)", company_id)
      }

      safe_attributes 'company_ids',
        :if => lambda {|user, current_user| current_user.admin? && !user.new_record?}
    end
  end

  module ClassMethods
  end

  module InstanceMethods
  end
end

Rails.application.config.to_prepare do
  User.send :include, EspeoEmployeesCompanies::Patches::UserPatch
end
