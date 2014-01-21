class AlumniAddress < ActiveRecord::Base

  attr_accessible :comment, :email, :name, :vulgo, :address_attributes
  has_one :address, as: :addressable, dependent: :destroy

  accepts_nested_attributes_for :address

  validates :email, uniqueness: true, format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :email, :name, presence: true

end
