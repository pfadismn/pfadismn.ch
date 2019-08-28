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

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
