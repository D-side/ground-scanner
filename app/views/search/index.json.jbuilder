json.result(@cities) do |city|
  json.extract! city, :name, :x, :y
end
json.page(@cities.current_page)
json.total_pages(@cities.total_pages)
