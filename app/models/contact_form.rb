class ContactForm

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name
  attr_accessor :organisational_unit

  def initialize(attributes = {})
    @sent = false

    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    @sent
  end

  def save
    @organisational_unit.team.each do |team_member|
      next unless team_member.user.present?

      UserMailer.contact_form_notification(team_member.user, self).deliver
    end
  end

end