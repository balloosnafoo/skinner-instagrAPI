require 'net/http'

class Collection < ActiveRecord::Base
  validates :tag, :begin_time, :end_time, presence: true

  has_many :posts

  def populate
    result = JSON.parse(Net::HTTP.get(URI.parse(construct_url)))
    next_page = result["pagination"]["next_url"]
    loop do
      create_posts_from_payload(result)
      break unless next_page && data_not_too_old(result["data"].last["created_time"])
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
      media_url = determine_media_url(datum)
      posts.create!(
        link:       datum["link"],
        caption:    datum["caption"]["text"],
        username:   datum["user"]["username"],
        media_url:  media_url,
        media_type: datum["type"],
        tag_time:   date
      )
    end
  end

  private
  def self.get_or_create(params)
    Collection.includes(:posts).find_by(params) || Collection.new(params)
  end

  def construct_url
    url =  "https://api.instagram.com/v1/tags/#{tag}/media/recent?"
    url +=  "client_id=d8733e3f2f4e428d937daa4a93f25da0"
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

  def determine_media_url(datum)
    if datum["type"] == "video"
      datum["videos"]["standard_resolution"]["url"]
    elsif datum["type"] == "image"
      datum["images"]["standard_resolution"]["url"]
    end
  end

  def within_range?(time)
    begin_time < time.to_i && time.to_i < end_time
  end

  def data_not_too_old(time)
    begin_time < time.to_i
  end
end
