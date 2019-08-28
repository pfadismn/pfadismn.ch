# == Schema Information
#
# Table name: member_functions
#
#  id    :integer          not null, primary key
#  name  :string
#  email :string
#  mask  :integer
#

class MemberFunction < ActiveRecord::Base
  FUNCTIONS = [:neumitglied, :mitglied, :gruppenleiter, :stammleiter,  :stufenleiter, :al, :skauty, :webmaster,
    :materialverantwortlicher, :coach, :praeses, :kassier]

end
