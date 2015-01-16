class Client < Principal
  include Redmine::SafeAttributes

  has_and_belongs_to_many :companies,
                          :join_table   => "#{table_name_prefix}companies_users#{table_name_suffix}"

  acts_as_customizable

  validates_presence_of :lastname
  validates_uniqueness_of :lastname, :case_sensitive => false
  validates_length_of :lastname, :maximum => 255

  scope :sorted, lambda { order("#{table_name}.lastname ASC") }
  scope :named, lambda {|arg| where("LOWER(#{table_name}.lastname) = LOWER(?)", arg.to_s.strip)}

  safe_attributes 'name',
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
