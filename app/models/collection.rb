class Collection < ActiveRecord::Base
  validates :tag, :begin_time, :end_time, presence: true

  has_many :posts

  def populate
    result = JSON.parse(Net::HTTP.get(URI.parse(construct_url)))
    next_page = result["pagination"]["next_url"]
    loop do
      create_posts_from_payload(result)
      break unless next_page
      result = JSON.parse(Net::HTTP.get(URI.parse(next_page)))
      next_page = result["pagination"]["next_url"]
    end
  end

  def get_data
    JSON.parse(Net::HTTP.get(URI.parse(construct_url)))
  end

  def create_posts_from_payload(payload)
    payload["data"].each do |datum|
      next unless within_range?(datum["created_time"])
      date = determine_tag_time(datum)
      posts.create!(
        link:       datum["link"],
        image_url:  datum["images"]["standard_resolution"]["url"],
        caption:    datum["caption"]["text"],
        username:   datum["user"]["username"],
        media_type: datum["type"],
        tag_time:   date
      )
    end
  end

  private
  def self.get_or_create(params)
    Collection.includes(:posts).find_by(params) || Collection.create(params)
  end

  def construct_url
    url =  "https://api.instagram.com/v1/tags/#{tag}/media/recent?"
    url += "client_id=d8733e3f2f4e428d937daa4a93f25da0"
  end

  def determine_tag_time(datum)
    date = nil
    unless datum["caption"]["text"] =~ /#{tag}/
      datum["comments"]["data"].each do |comment|
        if comment["text"] =~ /#{tag}/ &&
           comment["username"] == datum["user"]["username"]
          date = comment["created_time"]
        end
      end
    end
    date || datum["created_time"]
  end

  def within_range?(time)
    begin_time < time.to_i && time.to_i < end_time
  end
end
