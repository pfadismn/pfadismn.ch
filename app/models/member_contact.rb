class MemberContact < ActiveRecord::Base
  RELATIONS = [:mother, :father]

  # Relations
  belongs_to :member
  belongs_to :contact

  # Validations
  validates :relation, presence: true
end