Dado('que llueve') do
  request = { esta_lloviendo: true }.to_json
  Faraday.put(mock_lluvia_url, request, header)
end

Dado('que no llueve') do
  request = { esta_lloviendo: false }.to_json
  Faraday.put(mock_lluvia_url, request, header)
end
