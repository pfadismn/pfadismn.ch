# == Schema Information
#
# Table name: organisational_units
#
#  id                   :integer          not null, primary key
#  name                 :string
#  motto                :string
#  caption              :string
#  responsible_function :string
#  parent_id            :integer
#  lft                  :integer
#  rgt                  :integer
#  created_at           :datetime
#  updated_at           :datetime
#  active               :boolean          default(TRUE)
#  email                :string
#

require 'test_helper'

class OrganisationalUnitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
