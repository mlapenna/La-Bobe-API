Dado('que consulto mi pedido') do
  @response = Faraday.get(estado_pedido_url + "/#{@id_ultimo_usuario_registrado}/#{@id_pedido}")
  expect(@response.status).to eq(200)
end

Cuando('cancelo el pedido') do
  parsed_response = JSON.parse(@response.body)
  @response = Faraday.put(cancelar_pedido_url + "/#{parsed_response["id"]}")
end
