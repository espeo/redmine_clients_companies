class Company < Principal
  include Redmine::SafeAttributes

  has_and_belongs_to_many :employees,
                          :join_table   => "#{table_name_prefix}groups_users#{table_name_suffix}",
                          :foreign_key => :group_id,
                          :association_foreign_key => :user_id
  has_and_belongs_to_many :users,
                          :join_table   => "#{table_name_prefix}groups_users#{table_name_suffix}",
                          :foreign_key => :group_id

  acts_as_customizable

  MAIL_LENGTH_LIMIT = 60
  validates_presence_of :lastname
  validates_uniqueness_of :lastname, :case_sensitive => false
  validates_length_of :lastname, :maximum => 255
  validates_format_of :mail, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :allow_blank => true
  validates_length_of :mail, :maximum => MAIL_LENGTH_LIMIT, :allow_nil => true

  scope :sorted, lambda { order("#{table_name}.lastname ASC") }
  scope :named, lambda {|arg| where("LOWER(#{table_name}.lastname) = LOWER(?)", arg.to_s.strip)}

  safe_attributes 'name',
    'mail',
    'employee_ids',
    'custom_field_values',
    'custom_fields',
    :if => lambda {|group, user| user.admin?}

  def to_s
    lastname.to_s
  end

  def name
    lastname
  end

  def name=(arg)
    self.lastname = arg
  end

  def self.human_attribute_name(attribute_key_name, *args)
    attr_name = attribute_key_name.to_s
    if attr_name == 'lastname'
      attr_name = "name"
    end
    super(attr_name, *args)
  end
end
