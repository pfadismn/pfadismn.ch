# encoding: UTF-8
class Event < ActiveRecord::Base
  # Relations
  belongs_to :organisational_unit
  belongs_to :creator, class_name: 'User'
  belongs_to :start_place, class_name: 'Place'
  belongs_to :end_place, class_name: 'Place'
  attr_accessor :send_reminder

  # Attachment
  has_attached_file :content_image, styles: {large: '610x800>', medium: '305x400>', small: '150x200>'}, path: ':rails_root/var/attachments/:class/:attachment/:id/:style/:filename'

  # Validations
  validates :name, :start_time, :end_time, :organisational_unit, presence: true
  validate do
    unless start_time < end_time
      errors.add :end_time, I18n.t(:date_must_be_later_than)
    end
  end

  after_save :queue_reminder

  # Scopes
  scope :chronological, -> { order('start_time ASC') }
  scope :active, -> { where('published_at <= ?', Time.now).chronological }
  scope :upcoming, -> { where('end_time >= ?', Time.now).chronological }

  def published
    published_at.present? && published_at <= Time.current
  end

  def remind_at
    start_time - ENV['event_reminder_forerun_hours'].to_i.hours
  end

  def queue_reminder
    UserMailer.delay(run_at: remind_at, queue: :event_reminder).upcoming_event(self) if send_reminder
  end
end
