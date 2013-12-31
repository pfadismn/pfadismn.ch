class MailAlias < ActiveRecord::Base

  attr_accessor :generic

  default_scope ->() { order("alias ASC") }

  def self.generic
    MailAlias.find_by_sql("SELECT email, alias FROM forwarding_generic ORDER BY alias ASC;").map { |a| a.generic = true; a }
  end
end
