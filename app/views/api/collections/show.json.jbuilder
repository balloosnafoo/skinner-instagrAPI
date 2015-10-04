# Collection info
json.extract! @collection, :id, :tag, :begin_time, :end_time

# Post info
json.posts do
  json.array! @collection.posts do |post|
    json.extract! post, :id, :link, :media_url, :username,
                        :tag_time, :media_type, :caption
  end
end
