class MailAlias < ActiveRecord::Base

  attr_accessor :generic

  validates presence: false, :generic
end
