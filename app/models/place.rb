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

class Place < ActiveRecord::Base
  belongs_to :address
  
  def to_s
    name
  end
end
