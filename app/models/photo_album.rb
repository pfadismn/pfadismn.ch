class PhotoAlbum < ApplicationRecord
  validates :title, :year, :flickr_url, presence: true

  before_save :extract_flickr_id

  def extract_flickr_id
    self.flickr_id ||= flickr_url.split('/').last
  end
end
