class Address < ActiveRecord::Base
  # Relations
  belongs_to :addressable, polymorphic: true

end
