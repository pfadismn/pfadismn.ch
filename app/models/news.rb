class News < ActiveRecord::Base
  # Relations
  belongs_to :creator, class_name: 'User'
  
  # Scopes
  default_scope order('published_at DESC')
  
  def to_html
    RedCloth.new(body).to_html.html_safe
  end
end
