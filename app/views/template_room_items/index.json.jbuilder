json.array!(@template_room_items) do |template_room_item|
  json.extract! template_room_item, :id
  json.url template_room_item_url(template_room_item, format: :json)
end
