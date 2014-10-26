json.array!(@histories) do |history|
  json.extract! history, :id, :tagline, :body, :opt_timestamp
  json.url history_url(history, format: :json)
end
