Dado('que existe un pedido menu {string}') do |menu|
  @request = {menu: menu,
              usuario: "Ale",
              id_usuario: @id_ultimo_usuario_registrado
  }.to_json
  @response = Faraday.post(create_pedido_de_usuario_url, @request, header)
  expect(@response.status).to eq(201)
  parsed_response = JSON.parse(@response.body)
  @id_pedido = parsed_response['id']
end

Cuando('quiero calificar el pedido') do
  @request = { puntaje: 4,
               id_pedido: @id_pedido
  }.to_json
  @response = Faraday.put(calificar_pedido_url, @request, header)
  parsed_response = JSON.parse(@response.body)
  if parsed_response['estado'] == ESTADO_PEDIDO::ENTREGADO
    expect(@response.status).to eq(200)
  end
  @id_pedido = parsed_response['id']
end

Cuando('quiero volver a calificar el pedido') do
  @request = { puntaje: 3,
               id_pedido: @id_pedido
  }.to_json
  @response = Faraday.put(calificar_pedido_url, @request, header)
  parsed_response = JSON.parse(@response.body)
  if parsed_response['estado'] == ESTADO_PEDIDO::ENTREGADO
    expect(@response.status).to eq(200)
  end
end

Cuando('califico el pedido con puntaje {int}') do |puntaje|
  @request = { puntaje: puntaje,
               id_pedido: @id_pedido
  }.to_json
  @response = Faraday.put(calificar_pedido_url, @request, header)
  parsed_response = JSON.parse(@response.body)
  @id_pedido = parsed_response['id']
end

Cuando('califico el pedido con puntaje {int},{int}') do |puntaje_enteros, puntaje_decimales|
  puntaje_compuesto = "#{puntaje_enteros.to_s}.#{puntaje_decimales.to_s}"
  @request = { puntaje: puntaje_compuesto,
               id_pedido: @id_pedido
  }.to_json
  @response = Faraday.put(calificar_pedido_url, @request, header)
end

Cuando('califico el pedido con puntaje {string}') do |puntaje|
  @request = { puntaje: puntaje,
               id_pedido: @id_pedido
  }.to_json
  @response = Faraday.put(calificar_pedido_url, @request, header)
end

Entonces('recibo el mensaje por calificar {string}') do |mensaje|
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['respuesta']).to eq(mensaje)
end

Entonces('recibo el mensaje con el error {string}') do |mensaje|
  expect(@response.status).to eq(405)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['respuesta']).to eq(mensaje)
end
