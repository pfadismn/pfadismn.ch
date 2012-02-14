class Contact < ActiveRecord::Base

  # Relations
  has_one :address, as: :addressable
  has_one :phone_number, as: :phonable
  has_many :member_contacts
  has_many :members, through: :member_contacts

  accepts_nested_attributes_for :address, :phone_number, :member_contacts
end