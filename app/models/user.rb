class User < ActiveRecord::Base
  # Roles
  ROLES = [:admin, :manager, :leader]

  # Authlogic
  acts_as_authentic

  # Relations
  belongs_to :member

  #Validations
  validates :member, presence: true
  
  before_validation do
    self.email = member.email if member.present?
  end

  def to_s
    "#{email}"
  end
  
  def roles=(rs)
    unless rs.nil? || rs.empty?
      rs = rs.map { |r| r.is_a?(String) ? r.to_sym : r }
      self.roles_mask = (rs & ROLES).map { |r| 2**ROLES.index(r) }.sum
    else
      self.roles_mask = nil
    end
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def has_role? rs
    if rs.is_a? Array
      rs.each do |r|
        return true if has_role?(r)
      end
      return false
    end
    roles.include?(rs)
  end
  
  def reset_password
    reset_perishable_token!
    # TODO send mail
  end
end
