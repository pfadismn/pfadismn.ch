# == Schema Information
#
# Table name: members
#
#  id                     :integer          not null, primary key
#  organisational_unit_id :integer
#  first_name             :string
#  last_name              :string
#  scout_name             :string
#  alias                  :string
#  nationality            :string
#  remarks                :text
#  birthdate              :date
#  gender                 :integer
#  functions_mask         :integer
#  vegetarian             :boolean
#  member_since           :date
#  education              :text
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string
#

require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
