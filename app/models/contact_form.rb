class ContactForm

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::ForbiddenAttributesProtection

  attr_accessor :name, :email, :phone, :message
  attr_accessor :organisational_unit

  validates_presence_of :name, :message


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
    return false unless valid?

    @organisational_unit.team.each do |team_member|

      next unless team_member.user.present?

      UserMailer.contact_form_notification(team_member.user, self).deliver
    end
  end

end