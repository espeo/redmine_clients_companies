class Employee < Principal
  include Redmine::SafeAttributes

  has_and_belongs_to_many :companies,
                          :join_table   => "#{table_name_prefix}groups_users#{table_name_suffix}",
                          :foreign_key => :user_id,
                          :association_foreign_key => :group_id

  acts_as_customizable

  MAIL_LENGTH_LIMIT = 60
  validates_presence_of :firstname, :lastname
  validates_length_of :firstname, :lastname, :maximum => 30
  validates_format_of :mail, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :allow_blank => true
  validates_length_of :mail, :maximum => MAIL_LENGTH_LIMIT, :allow_nil => true

  scope :sorted, lambda { order(*User.fields_for_order_statement)}
  scope :in_company, lambda {|company|
    company_id = company.is_a?(Company) ? company.id : company.to_i
    where("#{Employee.table_name}.id IN (SELECT gu.user_id FROM #{table_name_prefix}groups_users#{table_name_suffix} gu WHERE gu.group_id = ?)", company_id)
  }
  scope :not_in_company, lambda {|company|
    company_id = company.is_a?(Company) ? company.id : company.to_i
    where("#{Employee.table_name}.id NOT IN (SELECT gu.user_id FROM #{table_name_prefix}groups_users#{table_name_suffix} gu WHERE gu.group_id = ?)", company_id)
  }

  safe_attributes 'firstname',
    'lastname',
    'mail',
    'custom_field_values',
    'custom_fields',
    'company_ids',
    :if => lambda {|group, user| user.admin?}

  def to_s
    name
  end

  def self.name_formatter(formatter = nil)
    User::USER_FORMATS[formatter || Setting.user_format] || User::USER_FORMATS[:firstname_lastname]
  end

  # Returns an array of fields names than can be used to make an order statement for employees
  # according to how employee names are displayed
  # Examples:
  #
  #   Employee.fields_for_order_statement              => ['employees.login', 'employees.id']
  #   Employee.fields_for_order_statement('authors')   => ['authors.login', 'authors.id']
  def self.fields_for_order_statement(table=nil)
    table ||= table_name
    name_formatter[:order].map {|field| "#{table}.#{field}"}
  end

  # Return employee's full name for display
  def name(formatter = nil)
    f = self.class.name_formatter(formatter)
    if formatter
      eval('"' + f[:string] + '"')
    else
      @name ||= eval('"' + f[:string] + '"')
    end
  end
end
