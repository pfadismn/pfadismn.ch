# == Schema Information
#
# Table name: member_contacts
#
#  contact_id :integer
#  member_id  :integer
#  relation   :string
#

class MemberContact < ActiveRecord::Base
  RELATIONS = [:mother, :father]

  # Relations
  belongs_to :member
  belongs_to :contact

  # Validations
  validates :relation, presence: true
end
