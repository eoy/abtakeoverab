json.array!(@announcements) do |announcement|
  json.extract! announcement, :title, :description, :document
  json.url announcement_url(announcement, format: :json)
end
