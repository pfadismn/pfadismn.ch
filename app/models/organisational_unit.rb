class OrganisationalUnit < ActiveRecord::Base
  # Relations
  has_many :direct_members, class_name: 'Member'
  has_many :direct_events, class_name: 'Event'
  acts_as_nested_set

  #Validations
  validates :name, presence: true, uniqueness: true
  
  # Scopes
  scope :active, where(active: true)
  
  def to_param
    "#{name.gsub(/[^a-z0-9]+/i, '_')}".downcase
  end
  
  def members
    Member.where(organisational_unit_id: self_and_descendants.map(&:id) )
  end
  
  def events
      Event.where(organisational_unit_id: self_and_ancestors.map(&:id) )
  end

  def inherited_and_propageted_events
    Event.where(organisational_unit_id: (self.descendants.map(&:id) + self.ancestors.map(&:id) << self.id))
  end
  
  def team
    members.by_function(responsible_function.to_sym) if MemberFunction::FUNCTIONS.index(responsible_function.to_sym)
  end

  def to_s
    return [parent.to_s, name].delete_if { |o| o.blank? }.join(" / ")
  end
  
  
end