json.array!(@bids) do |bid|
  json.extract! bid, :id, :index
  json.url bid_url(bid, format: :json)
end
