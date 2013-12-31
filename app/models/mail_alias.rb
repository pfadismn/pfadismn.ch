class MailAlias < ActiveRecord::Base

  attr_accessor :generic

  def self.generic
    MailAlias.find_by_sql("SELECT email, alias FROM forwarding_generic;").map { |a| a.generic = true; a }
  end
end
