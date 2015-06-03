json.array!(@images) do |image|
  json.extract! image, :id, :index, :show
  json.url image_url(image, format: :json)
end
