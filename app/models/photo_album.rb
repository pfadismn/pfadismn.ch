# == Schema Information
#
# Table name: photo_albums
#
#  id          :bigint(8)        not null, primary key
#  year        :integer
#  title       :string
#  description :string
#  place       :string
#  flickr_id   :string
#  flickr_url  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PhotoAlbum < ApplicationRecord
  validates :title, :year, :flickr_url, presence: true

  before_save :extract_flickr_id

  def extract_flickr_id
    self.flickr_id = flickr_url.split('/').last
  end
end
