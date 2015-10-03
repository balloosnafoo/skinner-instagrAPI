class Post < ActiveRecord::Base
  validates :link, :image_url, :username, :created_at, presence: true

  belongs_to :collection
end
