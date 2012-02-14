class PhoneNumber < ActiveRecord::Base
  PHONE_TYPES = [:home, :work, :mobile, :fax]

  # Relations
  belongs_to :phonable, polymorphic: true

  def to_s
    "#{phone_type}: #{number}"
  end
end
