# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  member_id         :integer
#  email             :string           not null
#  crypted_password  :string           not null
#  password_salt     :string           not null
#  persistence_token :string           not null
#  perishable_token  :string           not null
#  roles_mask        :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
