class Member < ActiveRecord::Base
  GENDERS = [[:male, 0], [:female, 1]]
  FUNCTIONS = [:neumitglied, :mitglied, :gruppenleiter, :stammleiter,  :stufenleiter, :al, :skauty, :webmaster, :matchef, :coach]

  # Relations
  belongs_to :organisational_unit
  has_many :addresses, as: :addressable
  has_many :phone_numbers, as: :phonable
  has_many :member_contacts
  has_many :contacts, through: :member_contacts
  has_one :user, dependent: :delete

  # Attachment
  has_attached_file :avatar, styles: { medium: "300x400>", thumb: "150x200>" }, path: ':rails_root/var/attachments/:class/:attachment/:id/:style/:filename'
  accepts_nested_attributes_for :addresses, :phone_numbers

  # Validations
  validates :login, uniqueness: true, format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }, if: Proc.new { |m| m.email.present? }
  validates :email, uniqueness: true, format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }, if: Proc.new { |m| m.email.present? || m.login.present? }
  validates :first_name, :last_name, presence: true
  validates :birthdate, :organisational_unit, presence: true
  
  # Scopes
  scope :by_function, ->(function) { where('functions_mask & ? > 0', 2**FUNCTIONS.index(function)) }
  
  # Hooks
  after_save do
    user.update_attribute(:email, login) if user.present?
  end  
    
  def to_s
    name
  end
    
  def name
    ["#{first_name} #{last_name}", ("#{scout_name}" if scout_name)].join(" / ")
  end

  def functions=(fs)
    fs = fs.map { |f| f.is_a?(String) ? f.to_sym : f }
    self.functions_mask = (fs & FUNCTIONS).map { |f| 2**FUNCTIONS.index(f) }.sum
  end

  def functions
    FUNCTIONS.reject do |f|
      ((functions_mask || 0) & 2**FUNCTIONS.index(f)).zero?
    end
  end

  def has_function? f
    functions.include?(f)
  end
  
  def last_education n
    education.lines.to_a.compact.last(n)
  end
end
