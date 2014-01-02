class News < ActiveRecord::Base
  PUBLISH_TO = [:web, :leiter, :members, :subscribers]
  # Relations
  belongs_to :creator, class_name: 'User'
  
  # Scopes
  default_scope order('published_at DESC')
  scope :published, ->() { where('published_at <= ?', DateTime.now) }
  scope :published_to, ->(to) { published.where('publish_to_mask & ?', 2**PUBLISH_TO.index(to)) }

  after_save :publish
  
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

  def publish
    receipients = []
    receipients += ["filou@pfadismn.ch"] if publish_to.include?(:leiter)
    receipients += ["gulli@pfadismn.ch"] if publish_to.include?(:members)
    #receipients += Subscriber.all.map { |s| s.email } if @news.publish_to.include? :subscribers

    UserMailer.delay(run_at: published_at).newsletter(receipients, self)
    #UserMailer.newsletter(receipients, self).deliver
  end
end
