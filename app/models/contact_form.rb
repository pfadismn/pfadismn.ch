class ContactForm

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::ForbiddenAttributesProtection

  attr_accessor :name, :email, :phone, :message
  attr_accessor :organisational_unit

  validates_presence_of :name, :message
  validates_presence_of :email, if: ->(cf) { cf.phone.blank? }
  validates_presence_of :phone, if: ->(cf) { cf.email.blank? }

  def self.i18n_scope
    :activerecord
  end

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
    UserMailer.contact_form_notification(self).deliver
    @sent = true
  end

end