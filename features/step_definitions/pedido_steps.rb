Dado('que ya estoy registrado como usuario en el Telegram de la Bobe') do
  @id_ultimo_usuario_registrado = 1
  @request = {nombre: 'Juan',
              direccion: 'La Pampa 123',
              telefono: 12345678,
              id_usuario: @id_ultimo_usuario_registrado
  }.to_json
  @response = Faraday.post(create_user_url, @request, header)
  expect(@response.status).to eq(201)
end

Dado('que consulto las opciones de menu') do
  @response = Faraday.get("#{BASE_URL}/menu")
  expect(@response.status).to eq(200)
end

When('pido el menu {string}') do |menu|
  @request = {menu: menu,
              usuario: 'Juan',
              id_usuario: @id_ultimo_usuario_registrado
  }.to_json
  @response = Faraday.post(create_pedido_de_usuario_url, @request, header)
end

Entonces('recibo el mensaje de confirmación {string}') do |mensaje|
  expect(@response.status).to eq(201)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['respuesta']).to eq(mensaje)
end

When(/^consulto mi pedido$/) do
  parsed_response = JSON.parse(@response.body)
  @response = Faraday.get(estado_pedido_url + "/#{@id_ultimo_usuario_registrado}/#{parsed_response['id']}")
  expect(@response.status).to eq(200)
end

Entonces('recibo el mensaje de error {string}') do |mensaje|
  expect(@response.status).to eq(406)
  parsed_response = JSON.parse(@response.body)
  expect(mensaje).to eq(parsed_response['respuesta'])
end

When(/^el estado del pedido es "([^"]*)"$/) do |mensaje|
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['estado']).to eq(mensaje)
end

When(/^progreso el estado del pedido$/) do
  parsed_response = JSON.parse(@response.body)
  @id_pedido = parsed_response['id'] if @id_pedido.nil?
  # @id_pedido = parsed_response['id']
  @request = {menu: parsed_response['menu'],
              usuario: 'Juan',
              id: @id_pedido
  }.to_json
  @response = Faraday.put(progresar_estado_pedido_url, @request, header)
end

Entonces('es asignado al primer repartidor sin pedidos') do
  parsed_response = JSON.parse(@response.body)
  @id_pedido = parsed_response['id'].to_i
  @response = Faraday.get(devolver_repartidor_url + "/#{parsed_response['id_repartidor']}")
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['id_pedido']).to eq([@id_pedido])
end
