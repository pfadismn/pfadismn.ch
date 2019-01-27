# == Schema Information
#
# Table name: news
#
#  id              :integer          not null, primary key
#  creator_id      :integer
#  title           :string
#  body            :text
#  published_at    :datetime
#  created_at      :datetime
#  updated_at      :datetime
#  publish_to_mask :integer          default(1)
#

require 'test_helper'

class NewsTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
