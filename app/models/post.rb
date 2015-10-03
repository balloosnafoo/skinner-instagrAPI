class Post < ActiveRecord::Base
  validates :media_type, :link, :image_url, :username, :tag_time, presence: true

  belongs_to :collection
end
