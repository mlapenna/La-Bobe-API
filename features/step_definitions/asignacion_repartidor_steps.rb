
id_repartidores = {}
id_pedidos = []

Dado('que el repartidor {string} está registrado') do |nombre|
  @repartidor = nombre
  @request = {nombre: @repartidor || "Mariano",
              dni: @dni || 22333444,
              telefono: @telefono || 1144445555
  }.to_json
  @response = Faraday.post(create_repartidor_url, @request, header)
  expect(@response.status).to eq(201)
  parsed_response = JSON.parse(@response.body)
  id_repartidores[nombre] = parsed_response['id']
end

Dado('que el Usuario {string} está registrado') do |nombre|
  @id_ultimo_usuario_registrado = 1
  @usuario = nombre
  @direccion = 'Echeverría 8000'
  @telefono = 34567890
  @request = {nombre: @usuario,
              direccion: @direccion,
              telefono: @telefono,
              id_usuario: @id_ultimo_usuario_registrado
  }.to_json
  @response = Faraday.post(create_user_url, @request, header)
  expect(@response.status).to eq(201)
end

Dado('que existe un pedido {string} para {string}') do |pedido, nombre|
  @request = {menu: 'Familiar',
              usuario: nombre,
              id_usuario: @id_ultimo_usuario_registrado }.to_json
  @response = Faraday.post(create_pedido_de_usuario_url, @request, header)
  parsed_response = JSON.parse(@response.body)
  id_pedidos = []
  id_pedidos.append(parsed_response['id'])
end

Dado('que el repartidor {string} no tiene pedidos') do |nombre|
  id = id_repartidores[nombre]
  @response = Faraday.get(devolver_repartidor_url + "/#{id}")
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['name']).to eq(nombre)
  expect(parsed_response['id_pedido']).to eq([])
end

Dado('que el repartidor {string} tiene pedidos') do |nombre|
  id_repartidor = id_repartidores[nombre]

  @request = {menu: 'Familiar',
              usuario: @usuario,
              id_usuario: @id_ultimo_usuario_registrado}.to_json
  @response = Faraday.post(create_pedido_de_usuario_url, @request, header)
  expect(@response.status).to eq(201)
  parsed_response = JSON.parse(@response.body)
  id_pedidos.append(parsed_response['id'])

  @request = {menu: parsed_response['menu'],
              usuario: parsed_response['usuario'],
              id: parsed_response['id']
  }.to_json
  @response = Faraday.put(progresar_estado_pedido_url, @request, header)
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)

  @request = {menu: parsed_response['menu'],
              usuario: parsed_response['usuario'],
              id: parsed_response['id']
  }.to_json
  @response = Faraday.put(progresar_estado_pedido_url, @request, header)
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)

  expect(parsed_response['id_repartidor']).to eq(id_repartidor.to_i)
end

Cuando('el estado del pedido {string} pasa de {string} a {string}') do |orden_pedido, estado1, estado2|
  orden = orden_pedido.to_i - 1
  id_pedido = id_pedidos[orden]
  @response = Faraday.get(estado_pedido_url + "/#{@id_ultimo_usuario_registrado}/#{id_pedido}")
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['estado']).to eq(estado1)
  @request = {menu: parsed_response['menu'],
              usuario: parsed_response['usuario'],
              id: parsed_response['id']
  }.to_json
  @response = Faraday.put(progresar_estado_pedido_url, @request, header)
  result = @response.status
  parsed_response = JSON.parse(@response.body)
  if result == 200
    expect(@response.status).to eq(200)
    expect(parsed_response['estado']).to eq(estado2)
  end
  @pedido = parsed_response['id']
end

Entonces('el mismo se asigna al repartidor {string}') do |nombre|
  id_repartidor = id_repartidores[nombre]
  @response = Faraday.get(devolver_repartidor_url + "/#{id_repartidor}")
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['name']).to eq(nombre)
  expect(parsed_response['id_pedido']).to include(@pedido.to_i)
end

Dado('que no existen repartidores') do
  @response = Faraday.delete(devolver_repartidor_url)
  expect(@response.status).to eq(200)
end

Entonces('se recibe un mensaje {string}') do |mensaje|
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['respuesta']).to eq(mensaje)
end

Dado('que realizo un nuevo pedido') do
  @request = {menu: 'Familiar',
              usuario: @usuario,
              id_usuario: @id_ultimo_usuario_registrado
  }.to_json
  @response = Faraday.post(create_pedido_de_usuario_url, @request, header)
  expect(@response.status).to eq(201)
  parsed_response = JSON.parse(@response.body)
  id_pedidos.append(parsed_response['id'])
end
