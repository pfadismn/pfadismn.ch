# == Schema Information
#
# Table name: phone_numbers
#
#  id            :integer          not null, primary key
#  phonable_id   :integer
#  phonable_type :string
#  phone_type    :string
#  number        :string
#  created_at    :datetime
#  updated_at    :datetime
#

require 'test_helper'

class PhoneNumberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
