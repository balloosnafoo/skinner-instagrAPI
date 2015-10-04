# Collection info
json.extract! @collection, :id, :tag, :begin_time, :end_time

# Post info
json.posts do
  json.array! @posts do |post|
    json.extract! post, :id, :link, :media_url, :username,
                        :tag_time, :media_type, :caption
  end
end

json.offset @offset + 20
