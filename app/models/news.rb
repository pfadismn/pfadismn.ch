class News < ActiveRecord::Base
  PUBLISH_TO = [:web, :leiter, :members]
  # Relations
  belongs_to :creator, class_name: 'User'

  # Scopes
  scope :published, -> { where(arel_table[:published_at].lteq(Time.zone.now)).order(published_at: :desc) }
  scope :published_to, ->(to) { published.where('publish_to_mask & ? > 0', 2**PUBLISH_TO.index(to)) }

  after_save :queue_newsletter

  def to_html
    RedCloth.new(body).to_html.html_safe
  end

  def publish_to
    PUBLISH_TO.reject do |f|
      ((publish_to_mask || 0) & 2**PUBLISH_TO.index(f)).zero?
    end
  end

  def publish_to=(ps)
    ps = ps.map { |p| p.is_a?(String) ? p.to_sym : p }
    self.publish_to_mask = (ps & PUBLISH_TO).map { |p| 2**PUBLISH_TO.index(p) }.sum
  end

  def queue_newsletter
    logger.debug(newsletter_receipients)
    UserMailer.newsletter(self).deliver if newsletter_receipients.any?
  end

  def newsletter_receipients
    receipients = []
    receipients += [ENV['newsletter_group_leiter']] if publish_to.include?(:leiter)
    receipients += [ENV['newsletter_group_members']] if publish_to.include?(:members)
    receipients.flatten
  end
end
