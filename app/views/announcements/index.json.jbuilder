json.array!(@announcements) do |announcement|
  json.extract! announcement, :title, :body, :for
  json.url announcement_url(announcement, format: :json)
end
