json.array!(@photos) do |photo|
  json.extract! photo, :id, :url, :lat, :long, :datetime
  json.url photo_url(photo, format: :json)
end
