# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  addressable_id   :integer
#  addressable_type :string
#  line1            :string
#  line2            :string
#  zip              :string
#  place            :string
#  country          :string
#  created_at       :datetime
#  updated_at       :datetime
#

class Address < ActiveRecord::Base
  # Relations
  belongs_to :addressable, polymorphic: true, required: false

end
