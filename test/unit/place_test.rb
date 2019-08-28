# == Schema Information
#
# Table name: places
#
#  id          :integer          not null, primary key
#  address_id  :integer
#  name        :string
#  description :text
#  coordinates :string
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class PlaceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
