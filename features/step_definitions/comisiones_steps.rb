Dado('que me registro como usuario') do
  @id_ultimo_usuario_registrado = 1
  @request = {nombre: 'Yo',
              direccion: 'Echeverría 8000',
              telefono: 34567890,
              id_usuario: @id_ultimo_usuario_registrado
  }.to_json
  @response = Faraday.post(create_user_url, @request, header)
  expect(@response.status).to eq(201)
end

Dado('que pido el menu {string}') do |menu|
  @request = {menu: menu,
              usuario: 'Juan',
              id_usuario: @id_ultimo_usuario_registrado
  }.to_json
  @response = Faraday.post(create_pedido_de_usuario_url, @request, header)
  expect(@response.status).to eq(201)
  parsed_response = JSON.parse(@response.body)
  @id_pedido = parsed_response['id']
end

Dado(/^que progreso el estado del pedido$/) do
  parsed_response = JSON.parse(@response.body)
  @id_pedido = parsed_response['id'] if @id_pedido.nil?
  @request = {menu: parsed_response['menu'],
              usuario: parsed_response['usuario'],
              id: @id_pedido
  }.to_json
  @response = Faraday.put(progresar_estado_pedido_url, @request, header)
  expect(@response.status).to eq(200)
end

Entonces('el repartidor recibe una comision de ${int} por el pedido') do |comision|
  @response = Faraday.get(comision_pedido_url + "/#{@id_pedido}")
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['monto']).to eq(comision)
end
