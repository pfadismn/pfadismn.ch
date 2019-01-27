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

class PhoneNumber < ActiveRecord::Base
  PHONE_TYPES = [:home, :work, :mobile, :fax]

  # Relations
  belongs_to :phonable, polymorphic: true

  def to_s
    "#{phone_type}: #{number}"
  end
end
