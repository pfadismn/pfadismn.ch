class Event < ActiveRecord::Base
  # Relations
  belongs_to :organisational_unit
  belongs_to :creator, class_name: 'User'
  belongs_to :start_place, class_name: 'Place'
  belongs_to :end_place, class_name: 'Place'
  
  # Attachment
  has_attached_file :content_image, styles: { large: "600x800>", medium: "300x400>", small: "150x200>" }, path: ':rails_root/var/attachments/:model/:attachment/:id/:style/:filename'
  
  # Validations
  validates :name, :start_time, :end_time, :organisational_unit, presence: true
  validate do
    unless start_time < end_time
      errors.add :end_time, I18n.t(:date_must_be_later_than)
    end
  end
  
  # Scopes
  default_scope order('start_time ASC')
  scope :active, where('published_at <= NOW()')
  scope :upcoming, where('start_time >= NOW()')
  
  def published
    published_at.present? && published_at <= Time.current
  end
end
