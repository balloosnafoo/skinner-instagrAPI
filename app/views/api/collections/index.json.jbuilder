json.array! @collections do |collection|
  json.extract! collection, :id, :tag, :begin_time, :end_time
end
