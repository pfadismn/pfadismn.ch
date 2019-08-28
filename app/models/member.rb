# == Schema Information
#
# Table name: members
#
#  id                     :integer          not null, primary key
#  organisational_unit_id :integer
#  first_name             :string
#  last_name              :string
#  scout_name             :string
#  alias                  :string
#  nationality            :string
#  remarks                :text
#  birthdate              :date
#  gender                 :integer
#  functions_mask         :integer
#  vegetarian             :boolean
#  member_since           :date
#  education              :text
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string
#

class Member < ActiveRecord::Base
  GENDERS = [:male,:female]

  # Relations
  belongs_to :organisational_unit
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :phone_numbers, as: :phonable, dependent: :destroy
  has_many :member_contacts, dependent: :destroy
  has_many :contacts, through: :member_contacts, dependent: :destroy
  has_one :user, dependent: :delete

  # Attachment
  has_attached_file :avatar, styles: { medium: '300x400>', thumb: '150x200>' }, path: ':rails_root/var/attachments/:class/:attachment/:id/:style/:filename'
  accepts_nested_attributes_for :addresses, :phone_numbers

  # Validations
  validates :alias, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, if: Proc.new { |m| m.email.present? }
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, if: Proc.new { |m| m.email.present? || m.alias.present? }
  validates :first_name, :last_name, presence: true
  validates :birthdate, :organisational_unit, presence: true
  validates_attachment :avatar, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }

  # Scopes
  scope :by_function, ->(function) { where('functions_mask & ? > 0', 2**MemberFunction::FUNCTIONS.index(function)) }

  # Hooks
  after_save do
    user.update_attribute(:email, self.alias) if user.present?
  end

  def to_s
    name
  end

  def name
    ["#{first_name} #{last_name}", ("#{scout_name}" if scout_name)].join(" / ")
  end

  def functions=(fs)
    fs = fs.map { |f| f.is_a?(String) ? f.to_sym : f }
    self.functions_mask = (fs & MemberFunction::FUNCTIONS).map { |f| 2**MemberFunction::FUNCTIONS.index(f) }.sum
  end

  def functions
    MemberFunction::FUNCTIONS.reject do |f|
      ((functions_mask || 0) & 2**MemberFunction::FUNCTIONS.index(f)).zero?
    end
  end

  def has_function? f
    functions.include?(f)
  end
  
  def last_education n
    education.lines.to_a.compact.last(n)
  end
end
