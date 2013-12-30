class MailAlias < ActiveRecord::Base

  attr_accessor :generic

  validates :generic, presence: false
end
