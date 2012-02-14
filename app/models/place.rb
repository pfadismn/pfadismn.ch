class Place < ActiveRecord::Base
  belongs_to :address
  
  def to_s
    name
  end
end
