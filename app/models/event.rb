# encoding: UTF-8

# == Schema Information
#
# Table name: events
#
#  id                         :integer          not null, primary key
#  organisational_unit_id     :integer
#  creator_id                 :integer
#  start_place_id             :integer
#  end_place_id               :integer
#  start_time                 :datetime
#  end_time                   :datetime
#  name                       :string
#  description                :text
#  take_along                 :text
#  content                    :text
#  published_at               :datetime
#  created_at                 :datetime
#  updated_at                 :datetime
#  content_image_file_name    :string
#  content_image_content_type :string
#  content_image_file_size    :integer
#  content_image_updated_at   :datetime
#  start_place_description    :string
#  end_place_description      :string
#

class Event < ActiveRecord::Base
  # Relations
  belongs_to :organisational_unit
  belongs_to :creator, class_name: :User
  belongs_to :start_place, class_name: :Place, optional: true
  belongs_to :end_place, class_name: :Place, optional: true
  attr_accessor :send_reminder

  # Attachment
  has_attached_file :content_image, styles: {large: '610x800>', medium: '305x400>', small: '150x200>'}, path: ':rails_root/var/attachments/:class/:attachment/:id/:style/:filename'

  # Validations
  validates :name, :start_time, :end_time, :organisational_unit, presence: true
  validate { errors.add(:end_time, :date_must_be_later_than) unless start_time && end_time && start_time <= end_time }
  validate { errors.add(:start_place, :blank) unless start_place || start_place_description.present? }

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

  def multi_day?
    start_time.to_date != end_time.to_date
  end
end
