class MailAlias < ActiveRecord::Base

  attr_accessor :generic

  scope :generic, ->() { find_by_sql("SELECT * FROM forwarding;") }
end
